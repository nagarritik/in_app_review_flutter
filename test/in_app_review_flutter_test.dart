import 'package:flutter_test/flutter_test.dart';

import 'package:in_app_review_flutter/in_app_review_flutter_platform_interface.dart';
import 'package:in_app_review_flutter/in_app_review_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInAppReviewFlutterPlatform
    with MockPlatformInterfaceMixin
    implements InAppReviewFlutterPlatform {
  @override
  Future<void> requestReview() => Future.value();

  @override
  Future<void> openStoreListing({
    String? appStoreId,
    String? microsoftStoreId,
  }) => Future.value();

  @override
  Future<bool> isAvailable() => Future.value(true);
}

void main() {
  final InAppReviewFlutterPlatform initialPlatform =
      InAppReviewFlutterPlatform.instance;

  test('$MethodChannelInAppReviewFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInAppReviewFlutter>());
  });
}
