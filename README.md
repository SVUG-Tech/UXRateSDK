<!-- BEGIN HEADER -->
# UXRateSDK

AI-powered in-app survey SDK for **iOS** and **Android**. Embed conversational surveys into your app with a single line of code.

## Platform Support

| Platform | Language | UI Framework | Min Version |
|----------|----------|-------------|-------------|
| iOS | Swift 5.9+ | SwiftUI / UIKit | iOS 17.0+ |
| Android | Kotlin 2.1+ | Jetpack Compose / Activities | API 24 (Android 7.0) |
| Flutter | Dart 3.0+ | — | iOS 17.0+ / API 24 |
| React Native | JS/TS | — | iOS 17.0+ / API 24 |
<!-- END HEADER -->

<!-- BEGIN OVERVIEW -->
## Overview

UXRate lets you run AI-powered conversational surveys inside your mobile app. Instead of static forms, users have a natural conversation with an AI interviewer that adapts follow-up questions based on responses.

**Key features:**
- **Targeted triggering** — show surveys on specific screens, after events, or to user segments
- **Session replay** — record user sessions with configurable quality (1-3 fps, auto-adapts to connection speed)
- **Event tracking** — track custom events and screen views alongside survey responses
- **Zero external dependencies** — uses only platform-native APIs
<!-- END OVERVIEW -->

---

<!-- BEGIN API_KEYS -->
## Getting Your API Key

1. Sign in to the [UXRate Dashboard](https://app.uxrate.com)
2. Navigate to your application
3. Go to the **API Key** tab
4. Copy your API key (starts with `uxr_`)

Use this key when calling `configure()` in your app. Each application has its own API key. Keep your key private — do not commit it to public repositories.
<!-- END API_KEYS -->

---

## Documentation

Full documentation is available on the **[Wiki](https://github.com/SVUG-Tech/UXRateSDK/wiki)**.

### iOS

```swift
dependencies: [
    .package(url: "https://github.com/SVUG-Tech/UXRateSDK.git", from: "0.2.0")
]
```

[Installation](https://github.com/SVUG-Tech/UXRateSDK/wiki/iOS-Installation) · [Quick Start](https://github.com/SVUG-Tech/UXRateSDK/wiki/iOS-Quick-Start) · [API Reference](https://github.com/SVUG-Tech/UXRateSDK/wiki/iOS-API-Reference) · [Event Tracking](https://github.com/SVUG-Tech/UXRateSDK/wiki/iOS-Event-Tracking) · [Session Replay](https://github.com/SVUG-Tech/UXRateSDK/wiki/iOS-Session-Replay)

### Android

```kotlin
dependencies {
    implementation("com.uxrate:uxrate-sdk:<version>")
}
```

[Installation](https://github.com/SVUG-Tech/UXRateSDK/wiki/Android-Installation) · [Quick Start](https://github.com/SVUG-Tech/UXRateSDK/wiki/Android-Quick-Start) · [API Reference](https://github.com/SVUG-Tech/UXRateSDK/wiki/Android-API-Reference) · [Event Tracking](https://github.com/SVUG-Tech/UXRateSDK/wiki/Android-Event-Tracking) · [Session Replay](https://github.com/SVUG-Tech/UXRateSDK/wiki/Android-Session-Replay)

### Flutter

```yaml
dependencies:
  flutter_uxrate:
    git:
      url: https://github.com/SVUG-Tech/flutter-uxrate.git
      ref: 0.2.0
```

[Installation](https://github.com/SVUG-Tech/UXRateSDK/wiki/Flutter-Installation) · [Quick Start](https://github.com/SVUG-Tech/UXRateSDK/wiki/Flutter-Quick-Start) · [API Reference](https://github.com/SVUG-Tech/UXRateSDK/wiki/Flutter-API-Reference) · [Event Tracking](https://github.com/SVUG-Tech/UXRateSDK/wiki/Flutter-Event-Tracking) · [Session Replay](https://github.com/SVUG-Tech/UXRateSDK/wiki/Flutter-Session-Replay)

### React Native

```bash
npm install react-native-uxrate
```

[Installation](https://github.com/SVUG-Tech/UXRateSDK/wiki/React-Native-Installation) · [Quick Start](https://github.com/SVUG-Tech/UXRateSDK/wiki/React-Native-Quick-Start) · [API Reference](https://github.com/SVUG-Tech/UXRateSDK/wiki/React-Native-API-Reference) · [Event Tracking](https://github.com/SVUG-Tech/UXRateSDK/wiki/React-Native-Event-Tracking) · [Session Replay](https://github.com/SVUG-Tech/UXRateSDK/wiki/React-Native-Session-Replay)

### Concepts

[SDK Overview](https://github.com/SVUG-Tech/UXRateSDK/wiki/SDK-Overview) · [Event Tracking](https://github.com/SVUG-Tech/UXRateSDK/wiki/Event-Tracking) · [Session Replay](https://github.com/SVUG-Tech/UXRateSDK/wiki/Session-Replay)

### Tutorials

- [iOS SwiftUI Integration](https://github.com/SVUG-Tech/UXRateSDK/wiki/Tutorial-iOS-SwiftUI-Integration)
- [iOS UIKit Integration](https://github.com/SVUG-Tech/UXRateSDK/wiki/Tutorial-iOS-UIKit-Integration)
- [Android Compose Integration](https://github.com/SVUG-Tech/UXRateSDK/wiki/Tutorial-Android-Compose-Integration)
- [Android Activities Integration](https://github.com/SVUG-Tech/UXRateSDK/wiki/Tutorial-Android-Activities-Integration)
- [Flutter Integration](https://github.com/SVUG-Tech/UXRateSDK/wiki/Tutorial-Flutter-Integration)
- [React Native + React Navigation](https://github.com/SVUG-Tech/UXRateSDK/wiki/Tutorial-React-Native-React-Navigation)

---

## Examples

See the [`examples/`](./examples) directory for working demo apps:

- [`examples/ios/`](./examples/ios/) — SwiftUI demo
- [`examples/ios-uikit/`](./examples/ios-uikit/) — UIKit + SwiftUI hybrid demo
- [`examples/android-compose/`](./examples/android-compose/) — Jetpack Compose + Navigation
- [`examples/android-activities/`](./examples/android-activities/) — Multi-Activity
- [`examples/flutter/`](./examples/flutter/) — Flutter demo
- [`examples/react-native/`](./examples/react-native/) — React Native demo

---

## License

Copyright UXRate. All rights reserved.
