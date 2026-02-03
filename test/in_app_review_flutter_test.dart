import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_review_flutter/in_app_review_flutter.dart';
import 'package:in_app_review_flutter/in_app_review_flutter_platform_interface.dart';
import 'package:in_app_review_flutter/in_app_review_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInAppReviewFlutterPlatform
    with MockPlatformInterfaceMixin
    implements InAppReviewFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InAppReviewFlutterPlatform initialPlatform = InAppReviewFlutterPlatform.instance;

  test('$MethodChannelInAppReviewFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInAppReviewFlutter>());
  });

  test('getPlatformVersion', () async {
    InAppReviewFlutter inAppReviewFlutterPlugin = InAppReviewFlutter();
    MockInAppReviewFlutterPlatform fakePlatform = MockInAppReviewFlutterPlatform();
    InAppReviewFlutterPlatform.instance = fakePlatform;

    expect(await inAppReviewFlutterPlugin.getPlatformVersion(), '42');
  });
}
