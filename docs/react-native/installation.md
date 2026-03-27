# Installation

## Requirements

- React Native 0.70+
- iOS 17.0+ / Android API 24+

## Install the package

```bash
npm install react-native-uxrate
# or
yarn add react-native-uxrate
```

## iOS Setup

Install the CocoaPods dependency:

```bash
cd ios && pod install
```

The UXRate iOS SDK is pulled automatically via the podspec.

## Android Setup

Add the UXRate Maven repository to your project-level `android/build.gradle`:

```groovy
allprojects {
    repositories {
        maven { url 'https://svug-tech.github.io/UXRateSDK' }
    }
}
```

The module auto-links -- no additional native setup is needed.

## Verify

Run your app on a device or simulator to confirm the module loads without errors:

```bash
npx react-native run-ios
# or
npx react-native run-android
```
