# in_app_review_flutter

A Flutter plugin for requesting and launching the In-App Review flow on Android and iOS. This plugin also supports checking availability and opening the store listing as a fallback.

## Features

* Request In-App Review flow.
* Check if the review flow is available.
* Open the app's store listing (Play Store / App Store) directly.
* Android support implemented.

## Usage

Import the package:

```dart
import 'package:in_app_review_flutter/in_app_review_flutter.dart';
```

Create an instance:

```dart
final InAppReviewFlutter inAppReview = InAppReviewFlutter();
```

### Request Review

To request the review flow:

```dart
// Check if review is available first (optional but recommended)
if (await inAppReview.isAvailable()) {
  await inAppReview.requestReview();
}
```

### Open Store Listing

To open the store listing directly (useful if in-app review is not available or quota is exceeded):

```dart
await inAppReview.openStoreListing();
```


