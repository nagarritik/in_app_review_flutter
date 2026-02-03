package com.ritiknagar.in_app_review_flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.app.Activity
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import android.content.Intent
import android.net.Uri
import android.content.ActivityNotFoundException
import com.google.android.play.core.review.ReviewInfo
import com.google.android.play.core.review.ReviewManager
import com.google.android.play.core.review.ReviewManagerFactory
import com.google.android.gms.tasks.Task

/** InAppReviewFlutterPlugin */
class InAppReviewFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var reviewInfo: ReviewInfo? = null
    private lateinit var reviewManager: ReviewManager

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "in_app_review_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "requestReview" -> {
                requestReview(result)
            }
            "openStoreListing" -> {
                openStoreListing(result)
            }
            "isAvailable" -> {
                checkAvailability(result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun checkAvailability(result: Result) {
        if (activity == null) {
            result.error("no_activity", "Activity is null", null)
            return
        }
        reviewManager = ReviewManagerFactory.create(activity!!)
        val request = reviewManager.requestReviewFlow()
        request.addOnCompleteListener { task: Task<ReviewInfo> ->
            if (task.isSuccessful) {
                reviewInfo = task.result
                result.success(true)
            } else {
                result.success(false)
            }
        }
    }

    private fun requestReview(result: Result) {
        if (activity == null) {
            result.error("no_activity", "Activity is null", null)
            return
        }
        
        // If we already have a valid ReviewInfo from isAvailable(), use it.
        // Otherwise, fetch it now.
        if (reviewInfo != null) {
            launchReviewFlow(reviewInfo!!, result)
            // Invalidating reviewInfo after use as it might be consumed
            reviewInfo = null 
        } else {
            reviewManager = ReviewManagerFactory.create(activity!!)
            val request = reviewManager.requestReviewFlow()
            request.addOnCompleteListener { task: Task<ReviewInfo> ->
                if (task.isSuccessful) {
                    launchReviewFlow(task.result, result)
                } else {
                    result.error("error", task.exception?.message, null)
                }
            }
        }
    }

    private fun launchReviewFlow(reviewInfo: ReviewInfo, result: Result) {
        val flow = reviewManager.launchReviewFlow(activity!!, reviewInfo)
        flow.addOnCompleteListener { _ ->
            result.success(null)
        }
    }

    private fun openStoreListing(result: Result) {
        if (activity == null) {
            result.error("no_activity", "Activity is null", null)
            return
        }
        val packageName = activity!!.packageName
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$packageName"))
        try {
            activity!!.startActivity(intent)
            result.success(null)
        } catch (e: ActivityNotFoundException) {
            val webIntent = Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=$packageName"))
            activity!!.startActivity(webIntent)
            result.success(null)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
