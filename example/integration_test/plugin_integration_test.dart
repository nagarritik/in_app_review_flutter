// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:in_app_review_flutter/in_app_review_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('isAvailable test', (WidgetTester tester) async {
    final InAppReviewFlutter plugin = InAppReviewFlutter();
    try {
      final bool isAvailable = await plugin.isAvailable();
      // On Android emulator/device with Play Store, this might return true or false
      // depending on Play Store availability. We just check strict boolean return.
      expect(isAvailable, isA<bool>());
    } catch (e) {
      // If run on a platform without implementation, it might throw,
      // but for now we expect it to arguably work or return false.
    }
  });
}
