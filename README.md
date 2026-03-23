# UXRateSDK

AI-powered in-app survey SDK for **iOS** and **Android**. Embed conversational surveys into your app with a single line of code.

## Platform Support

| Platform | Language | UI Framework | Min Version |
|----------|----------|-------------|-------------|
| iOS | Swift 5.9+ | SwiftUI | iOS 17.0+ |
| Android | Kotlin 2.1+ | Jetpack Compose | API 24 (Android 7.0) |
| Flutter | Dart 3.0+ | — | iOS 17.0+ / API 24 |
| React Native | JS/TS | — | iOS 17.0+ / API 24 |

---

## Installation

### iOS

**Swift Package Manager** — In Xcode: **File → Add Package Dependencies** → paste:

```
https://github.com/SVUG-Tech/UXRateSDK.git
```

Or add to `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SVUG-Tech/UXRateSDK.git", from: "0.1.0")
]
```

**CocoaPods** — Add to your `Podfile`:

```ruby
pod 'UXRateSDK', '~> 0.1.0'
```

### Android

Add the UXRate Maven repository and dependency:

```kotlin
// settings.gradle.kts (project-level)
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://svug-tech.github.io/UXRateSDK") }
    }
}

// build.gradle.kts (module-level)
dependencies {
    implementation("com.uxrate:uxrate-sdk:0.1.0")
}
```

No authentication required. Transitive dependencies resolve automatically.

<details>
<summary>Manual AAR download (alternative)</summary>

1. Download `uxrate-sdk-*.aar` from [Releases](https://github.com/SVUG-Tech/UXRateSDK/releases)
2. Copy to your module's `libs/` directory
3. Add dependencies manually:

```kotlin
dependencies {
    implementation(files("libs/uxrate-sdk-0.1.0.aar"))

    // Required transitive dependencies
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
</details>

### Flutter

```yaml
# pubspec.yaml
dependencies:
  flutter_uxrate: ^0.1.0
```

```bash
flutter pub get
cd ios && pod install   # iOS only
```

For Android, add the UXRate Maven repository to your **android/build.gradle**:

```groovy
allprojects {
    repositories {
        maven { url 'https://svug-tech.github.io/UXRateSDK' }
    }
}
```

> **Note:** Flutter runs inside a single native ViewController/Activity, so auto screen tracking won't distinguish between Flutter routes. Use `UXRate.setScreen('ScreenName')` manually on each route.

### React Native

```bash
npm install react-native-uxrate
cd ios && pod install   # iOS only
```

For Android, add the UXRate Maven repository to your **android/build.gradle**:

```groovy
allprojects {
    repositories {
        maven { url 'https://svug-tech.github.io/UXRateSDK' }
    }
}
```

> **Note:** Like Flutter, React Native uses a single native root. Use `UXRate.setScreen('ScreenName')` on navigation events rather than relying on auto-tracking.

---

## Getting Your API Key

1. Sign up or log in at [app.uxrate.com](https://app.uxrate.com/)
2. Create a project (or select an existing one)
3. Go to **Settings → API Keys**
4. Copy your API key (starts with `uxr_`)

Use this key in `UXRate.configure(apiKey: "uxr_...")` on any platform below.

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
                .surveyScreen("Home")
        }
    }
}
```

> SwiftUI apps must use `.surveyScreen()` to identify screens — the SDK cannot auto-detect them because iOS type-erases views internally. UIKit apps auto-detect screen names from view controller class names.

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

### Android

Register your `Application` class in `AndroidManifest.xml`:

```xml
<application android:name=".MyApp" ... >
```

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

> **Jetpack Compose + Navigation (recommended)** — one line auto-tracks all screens:
> ```kotlin
> val navController = rememberNavController()
> navController.TrackScreens()  // auto-tracks all navigation destinations
> ```
> **Compose without Navigation** — use `SurveyScreen("Home")` per screen (hides banner on leave, like iOS `.surveyScreen()`).
> **Multi-Activity apps** — auto-tracked from Activity class names.

<details>
<summary>Advanced configuration options</summary>

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
</details>

### Flutter

```dart
import 'package:flutter_uxrate/flutter_uxrate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UXRate.configure(apiKey: 'YOUR_API_KEY');
  runApp(const MyApp());
}

// On each screen:
@override
void initState() {
  super.initState();
  UXRate.setScreen('Home');
}
```

### React Native

```javascript
import { UXRate } from 'react-native-uxrate';

// App startup
useEffect(() => {
  UXRate.configure({ apiKey: 'YOUR_API_KEY' });
}, []);

// On each screen (with React Navigation)
useFocusEffect(() => {
  UXRate.setScreen('Home');
});
```

---

## User Identification & Event Tracking

These methods work identically across all platforms:

| | iOS (Swift) | Android (Kotlin) | Flutter (Dart) | React Native (JS) |
|---|---|---|---|---|
| **Identify** | `UXRate.identify(userId: "u1", properties: ["plan": "pro"])` | `UXRate.identify(userId = "u1", properties = mapOf("plan" to "pro"))` | `UXRate.identify(userId: 'u1', properties: {'plan': 'pro'})` | `UXRate.identify({ userId: 'u1', properties: { plan: 'pro' } })` |
| **Track** | `UXRate.track(event: "purchase")` | `UXRate.track(event = "purchase")` | `UXRate.track(event: 'purchase')` | `UXRate.track({ event: 'purchase' })` |
| **Screen** | `UXRate.setScreen("Cart")` | `UXRate.setScreen(name = "Cart")` | `UXRate.setScreen('Cart')` | `UXRate.setScreen('Cart')` |

---

## API Reference

| Method / Modifier | iOS | Android | Flutter | RN | Description |
|---|---|---|---|---|---|
| `configure(apiKey:)` | ✅ | ✅ | ✅ | ✅ | Initialize the SDK |
| `identify(userId:properties:)` | ✅ | ✅ | ✅ | ✅ | Set user identity for targeting |
| `track(event:)` | ✅ | ✅ | ✅ | ✅ | Track custom events |
| `setScreen(_:)` | ✅ | ✅ | ✅ | ✅ | Manually set the current screen name |
| `.surveyScreen("Name")` | ✅ | — | — | — | SwiftUI view modifier for screen identification |

---

## How It Works

1. **Configure** — SDK fetches survey config from the backend
2. **Screen tracking** — Screen names are detected (auto or manual)
3. **Trigger evaluation** — SDK checks if any survey matches the current screen, events, timing, and user segment
4. **Banner** — A non-intrusive banner overlay appears on matching screens
5. **Chat** — Tapping the banner opens an AI-powered survey conversation
6. **Frequency capping** — Per-user, per-session, cooldown, and daily caps prevent survey fatigue

---

## Examples

See the [`examples/`](./examples) directory for working demo apps:

- [`examples/ios/`](./examples/ios/) — SwiftUI demo
- [`examples/ios-uikit/`](./examples/ios-uikit/) — UIKit + SwiftUI hybrid demo
- [`examples/android/`](./examples/android/) — Jetpack Compose demo
- [`examples/flutter/`](./examples/flutter/) — Flutter demo
- [`examples/react-native/`](./examples/react-native/) — React Native demo

For detailed integration instructions (screen tracking patterns, trigger configuration, troubleshooting), see the **[Integration Guide](./INTEGRATION.md)**.

---

## License

Copyright UXRate. All rights reserved.
