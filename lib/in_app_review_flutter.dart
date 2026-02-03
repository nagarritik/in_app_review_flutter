import 'in_app_review_flutter_platform_interface.dart';

class InAppReviewFlutter {
  Future<void> requestReview() {
    return InAppReviewFlutterPlatform.instance.requestReview();
  }

  Future<void> openStoreListing({
    String? appStoreId,
    String? microsoftStoreId,
  }) {
    return InAppReviewFlutterPlatform.instance.openStoreListing(
      appStoreId: appStoreId,
      microsoftStoreId: microsoftStoreId,
    );
  }

  Future<bool> isAvailable() {
    return InAppReviewFlutterPlatform.instance.isAvailable();
  }
}
