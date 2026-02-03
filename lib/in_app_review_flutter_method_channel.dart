import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'in_app_review_flutter_platform_interface.dart';

/// An implementation of [InAppReviewFlutterPlatform] that uses method channels.
class MethodChannelInAppReviewFlutter extends InAppReviewFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('in_app_review_flutter');

  @override
  Future<void> requestReview() async {
    await methodChannel.invokeMethod('requestReview');
  }

  @override
  Future<void> openStoreListing({
    String? appStoreId,
    String? microsoftStoreId,
  }) async {
    await methodChannel.invokeMethod('openStoreListing', <String, dynamic>{
      'appStoreId': appStoreId,
      'microsoftStoreId': microsoftStoreId,
    });
  }

  @override
  Future<bool> isAvailable() async {
    final bool? isAvailable = await methodChannel.invokeMethod<bool>(
      'isAvailable',
    );
    return isAvailable ?? false;
  }
}
