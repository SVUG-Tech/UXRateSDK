# Installation

## Add the dependency

Add `flutter_uxrate` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_uxrate:
    git:
      url: https://github.com/SVUG-Tech/flutter-uxrate.git
      ref: 0.1.0
```

Then install:

```bash
flutter pub get
```

## Requirements

- Flutter 3.10+
- Dart SDK 3.0+
- iOS 17.0+
- Android API 24+

## iOS setup

Run CocoaPods to pull the native UXRate iOS SDK:

```bash
cd ios && pod install
```

The native SDK is resolved automatically via the plugin's podspec.

## Android setup

Add the UXRate Maven repository to your **android/build.gradle** (or `android/app/build.gradle`):

```groovy
repositories {
    maven { url 'https://svug-tech.github.io/UXRateSDK' }
}
```

No additional native setup is needed -- the plugin auto-links the Android SDK.

## Verify installation

Run the example app to confirm everything is wired up:

```bash
cd example
flutter run
```
