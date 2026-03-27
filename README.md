<!-- This file is auto-assembled. Edit common sections in docs/common/. Platform sections are synced from private repos on release. -->

# UXRateSDK

AI-powered in-app survey SDK for **iOS** and **Android**. Embed conversational surveys into your app with a single line of code.

## Platform Support

| Platform | Language | UI Framework | Min Version |
|----------|----------|-------------|-------------|
| iOS | Swift 5.9+ | SwiftUI / UIKit | iOS 17.0+ |
| Android | Kotlin 2.1+ | Jetpack Compose / Activities | API 24 (Android 7.0) |
| Flutter | Dart 3.0+ | — | iOS 17.0+ / API 24 |
| React Native | JS/TS | — | iOS 17.0+ / API 24 |

## Overview

UXRate lets you run AI-powered conversational surveys inside your mobile app. Instead of static forms, users have a natural conversation with an AI interviewer that adapts follow-up questions based on responses.

**Key features:**
- **Targeted triggering** — show surveys on specific screens, after events, or to user segments
- **Session replay** — record user sessions with configurable quality (1-3 fps, auto-adapts to connection speed)
- **Event tracking** — track custom events and screen views alongside survey responses
- **Zero external dependencies** — uses only platform-native APIs

## Getting Your API Key

1. Sign in to the [UXRate Dashboard](https://app.uxrate.com)
2. Navigate to your application
3. Go to the **API Key** tab
4. Copy your API key (starts with `uxr_`)

Use this key when calling `configure()` in your app. Each application has its own API key. Keep your key private — do not commit it to public repositories.

---

## iOS

<!-- BEGIN IOS -->
*iOS documentation will be populated on next release. See [docs/ios/](docs/ios/) for current platform docs.*
<!-- END IOS -->

---

## Android

<!-- BEGIN ANDROID -->
*Android documentation will be populated on next release. See [docs/android/](docs/android/) for current platform docs.*
<!-- END ANDROID -->

---

## Tutorials

See the [docs/tutorials/](docs/tutorials/) directory for step-by-step integration guides:
- iOS SwiftUI Integration
- iOS UIKit Integration
- Android Compose Integration
- Android Activities Integration

## Demo Apps

Working example apps are available in [examples/](examples/):
- `examples/ios/` — SwiftUI demo
- `examples/ios-uikit/` — UIKit demo
- `examples/android-compose/` — Jetpack Compose demo
- `examples/android-activities/` — Activity-based demo

## License

See [LICENSE](LICENSE) for details.
