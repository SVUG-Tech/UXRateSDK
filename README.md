# UXRateSDK

AI-powered in-app survey SDK for **iOS** and **Android**. Embed conversational surveys into your app with a single line of code.

## Platform Support

| Platform | Language | UI Framework | Min Version |
|----------|----------|-------------|-------------|
| iOS | Swift 5.9+ | SwiftUI | iOS 17.0+ |
| Android | Kotlin 2.1+ | Jetpack Compose | API 24 (Android 7.0) |

---

## iOS Installation

### Swift Package Manager

In Xcode: **File → Add Package Dependencies** → paste:

```
https://github.com/SVUG-Tech/UXRateSDK.git
```

Select version **0.1.0** or later.

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SVUG-Tech/UXRateSDK.git", from: "0.1.0")
]
```

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'UXRateSDK', '~> 0.1.0'
```

Then run `pod install`.

---

## Android Installation

### Option 1: Gradle (Maven Central) — Recommended

Add to your **module-level** `build.gradle.kts`:

```kotlin
dependencies {
    implementation("com.uxrate:uxrate-sdk:0.1.0")
}
```

That's it — Maven Central is included by default in Android projects. Transitive dependencies are resolved automatically.

### Option 2: AAR Download

1. Download the latest `uxrate-sdk-*.aar` from [Releases](https://github.com/SVUG-Tech/UXRateSDK/releases)
2. Copy the AAR file to your module's `libs/` directory
3. Add to your **module-level** `build.gradle.kts`:

```kotlin
dependencies {
    implementation(files("libs/uxrate-sdk-0.1.0.aar"))

    // Required transitive dependencies (AAR does not bundle these)
    implementation(platform("androidx.compose:compose-bom:2024.12.01"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.material:material-icons-core")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.activity:activity-compose:1.9.3")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.8.7")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.9.0")
}
```

> **Note:** With the Gradle approach, transitive dependencies are resolved automatically. With AAR download, you must declare them manually as shown above.

---

## Cross-Platform Installation

### Flutter

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_uxrate: ^0.1.0
```

Then run `flutter pub get` followed by `cd ios && pod install`.

### React Native

```bash
npm install react-native-uxrate
cd ios && pod install
```

For detailed integration instructions (SwiftUI, UIKit, Android, Flutter, React Native, screen tracking, triggers, troubleshooting), see the **[Integration Guide](./INTEGRATION.md)**.

---

## Quick Start

### iOS — SwiftUI

```swift
import SwiftUI
import UXRateSDK

@main
struct MyApp: App {
    init() {
        UXRate.configure(apiKey: "YOUR_API_KEY")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .surveyScreen("Home")   // required — identifies this screen for surveys
        }
    }
}
```

Screen names in pure SwiftUI apps must be set with `.surveyScreen()` — the SDK cannot auto-detect them because iOS type-erases views internally. For UIKit apps, screen names are auto-detected from the view controller class name.

### iOS — UIKit

```swift
import UIKit
import UXRateSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UXRate.configure(apiKey: "YOUR_API_KEY")
        return true
    }
}
```

### Android — Kotlin

Register your `Application` class in `AndroidManifest.xml`:

```xml
<application
    android:name=".MyApp"
    ... >
```

Then configure the SDK:

```kotlin
import android.app.Application
import com.uxrate.sdk.UXRate

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        UXRate.configure(
            application = this,
            apiKey = "YOUR_API_KEY"
        )
    }
}
```

Screen names are auto-detected from Activity class names (e.g., `HomeActivity` → `"Home"`). For manual override:

```kotlin
UXRate.setScreen(name = "Checkout")
```

Advanced configuration:

```kotlin
import com.uxrate.sdk.models.OverlapStrategy
import com.uxrate.sdk.models.SDKTheme

UXRate.configure(
    application = this,
    apiKey = "YOUR_API_KEY",
    baseURL = "https://app.uxrate.com",           // Custom backend URL
    autoTrackScreens = true,                       // Auto-track Activity names
    useMockService = false,                        // Mock data for development
    overlapStrategy = OverlapStrategy.SHOW_FIRST,  // Multiple survey resolution
    theme = SDKTheme.AUTO                          // Color scheme: AUTO, LIGHT, DARK
)
```

### User Identification & Event Tracking

**iOS (Swift):**
```swift
UXRate.identify(userId: "user-123", properties: ["plan": "pro"])
UXRate.track(event: "purchase_complete")
UXRate.setScreen("Checkout")
```

**Android (Kotlin):**
```kotlin
UXRate.identify(userId = "user-123", properties = mapOf("plan" to "pro"))
UXRate.track(event = "purchase_complete")
UXRate.setScreen(name = "Checkout")
```

### Flutter

```dart
import 'package:flutter_uxrate/flutter_uxrate.dart';

await UXRate.configure(apiKey: 'YOUR_API_KEY');
```

### React Native

```javascript
import { UXRate } from 'react-native-uxrate';

await UXRate.configure({ apiKey: 'YOUR_API_KEY' });
```

## API

| Method / Modifier | iOS | Android | Description |
|---|---|---|---|
| `configure(apiKey:)` | ✅ | ✅ | Initialize the SDK |
| `identify(userId:properties:)` | ✅ | ✅ | Set user identity for targeting |
| `track(event:)` | ✅ | ✅ | Track custom events |
| `setScreen(_:)` | ✅ | ✅ | Manually set the current screen name |
| `.surveyScreen("Name")` | ✅ | — | Identify a SwiftUI view for survey targeting |

## Examples

See the [`examples/`](./examples) directory for working demo apps:

- [`examples/ios/`](./examples/ios/) — SwiftUI demo
- [`examples/ios-uikit/`](./examples/ios-uikit/) — UIKit + SwiftUI hybrid demo
- [`examples/flutter/`](./examples/flutter/) — Flutter demo
- [`examples/react-native/`](./examples/react-native/) — React Native demo

## License

Copyright UXRate. All rights reserved.
