import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_review_flutter/in_app_review_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelInAppReviewFlutter platform = MethodChannelInAppReviewFlutter();
  const MethodChannel channel = MethodChannel('in_app_review_flutter');

  test('isAvailable', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'isAvailable') {
            return true;
          }
          return null;
        });
    expect(await platform.isAvailable(), true);
  });
}
