
import 'in_app_review_flutter_platform_interface.dart';

class InAppReviewFlutter {
  Future<String?> getPlatformVersion() {
    return InAppReviewFlutterPlatform.instance.getPlatformVersion();
  }
}
