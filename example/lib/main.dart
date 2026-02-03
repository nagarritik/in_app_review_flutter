import 'package:flutter/material.dart';

import 'package:in_app_review_flutter/in_app_review_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _inAppReviewFlutterPlugin = InAppReviewFlutter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _inAppReviewFlutterPlugin.requestReview();
                },
                child: const Text('Request Review'),
              ),
              ElevatedButton(
                onPressed: () {
                  _inAppReviewFlutterPlugin.openStoreListing();
                },
                child: const Text('Open Store Listing'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final isAvailable = await _inAppReviewFlutterPlugin
                      .isAvailable();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Is Review Available: $isAvailable'),
                    ),
                  );
                },
                child: const Text('Check Availability'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
