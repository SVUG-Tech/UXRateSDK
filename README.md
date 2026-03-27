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

## Getting Your API Key

1. Sign up or log in at [app.uxrate.com](https://app.uxrate.com/)
2. Create a project (or select an existing one)
3. Go to **Settings → API Keys**
4. Copy your API key (starts with `uxr_`)

---

## iOS

<!-- BEGIN IOS -->
<!-- iOS SDK v0.2.0 -->

# API Reference

All public API methods are static methods on the `UXRate` enum.

| Method | Signature | Description |
|--------|-----------|-------------|
| `configure` | `configure(apiKey:baseURL:autoTrackScreens:useMockService:overlapStrategy:theme:)` | Initializes the SDK. Call once at app launch. `baseURL` defaults to `https://app.uxrate.com`. `autoTrackScreens` (default `true`) swizzles UIViewController for automatic screen detection. `useMockService` (default `false`) uses a built-in mock backend for development. `overlapStrategy` (default `.showFirst`) controls how multiple matching surveys are resolved. `theme` (default `.auto`) sets the color scheme for all SDK UI. |
| `identify` | `identify(userId:properties:)` | Sets the current user ID and optional properties for segment targeting. Properties are merged with any previously set values. |
| `track` | `track(event:properties:)` | Tracks a custom event by name. Increments the local event count (used by `event` trigger rules) and enqueues the event for batch delivery. |
| `setScreen` | `setScreen(_:)` | Manually sets the current screen name. Overrides the auto-detected UIViewController class name. Required for SwiftUI screens when not using `.surveyScreen()`. |
| `loggingEnabled` | `loggingEnabled: Bool` | Static property that controls debug console output. Defaults to `true` in DEBUG builds, `false` in release. Set before calling `configure` to silence all SDK logs. |

## View Modifiers

| Modifier | Description |
|----------|-------------|
| `.surveyScreen(_ name: String)` | Marks a SwiftUI view as a targetable survey screen. The name is matched against `pagePattern` regex in trigger rules. Tracks the screen once per view lifecycle. |


<!-- iOS SDK v0.2.0 -->

# Event Tracking

UXRateSDK tracks three categories of events: custom events, screen views, and SDK lifecycle events.

## Custom Events

Track user actions that surveys can trigger on:

```swift
UXRate.track(event: "purchase_complete")
UXRate.track(event: "item_added_to_cart", properties: ["category": "electronics"])
```

Each call increments the event's local count and enqueues it for batch delivery. The `event` trigger rule type matches against event names and counts.

## Screen Tracking

**UIKit (automatic):** The SDK swizzles `UIViewController.viewDidAppear` to detect screen names from class names. Override the auto-detected name with:

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UXRate.setScreen("Checkout")
}
```

**SwiftUI (manual):** Add the `.surveyScreen()` modifier to each targetable view:

```swift
ContentView()
    .surveyScreen("Home")
```

Screen visits are counted locally and matched against `page_visit` trigger rules using regex patterns.

## SDK Lifecycle Events

The SDK automatically tracks these events internally. They are delivered to the backend as part of the event batch and are visible in the UXRate dashboard:

| Event Name                 | When Fired                                         |
|----------------------------|-----------------------------------------------------|
| `uxrate_banner_shown`      | A survey banner is displayed to the user            |
| `uxrate_survey_started`    | The user opens the conversational survey            |
| `uxrate_survey_closed`     | The user dismisses the survey without completing it |
| `uxrate_survey_completed`  | The backend signals the interview is finished       |

These events are tracked automatically and do not need to be called manually.


<!-- iOS SDK v0.2.0 -->

# Installation

UXRateSDK requires **iOS 17.0+** and **Swift 5.9+**. The SDK has zero external dependencies.

## Swift Package Manager (recommended)

1. In Xcode, go to **File > Add Package Dependencies...**
2. Enter the repository URL:
   ```
   https://github.com/SVUG-Tech/UXRateSDK.git
   ```
3. Select a version rule (e.g. **Up to Next Major Version**) and click **Add Package**.
4. Select the `UXRateSDK` library and add it to your app target.

Alternatively, add it directly in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SVUG-Tech/UXRateSDK.git", from: "0.1.0")
]
```

Then add `"UXRateSDK"` to your target's dependencies.

## CocoaPods

Add UXRateSDK to your `Podfile`:

```ruby
pod 'UXRateSDK'
```

Then run:

```bash
pod install
```

## Manual (XCFramework)

1. Download the latest `UXRateSDK.xcframework.zip` from the [Releases page](https://github.com/SVUG-Tech/UXRateSDK/releases).
2. Unzip and drag `UXRateSDK.xcframework` into your Xcode project.
3. In your target's **General > Frameworks, Libraries, and Embedded Content**, ensure UXRateSDK is set to **Embed & Sign**.


<!-- iOS SDK v0.2.0 -->

# Quick Start

Get UXRateSDK running in your iOS app in four steps.

## Step 1: Configure the SDK

Call `UXRate.configure` as early as possible in your app lifecycle.

**SwiftUI:**

```swift
import UXRateSDK

@main
struct MyApp: App {
    init() {
        UXRate.configure(apiKey: "uxr_your_api_key")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

**UIKit:**

```swift
import UXRateSDK

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UXRate.configure(apiKey: "uxr_your_api_key")
        return true
    }
}
```

## Step 2: Identify the user

Optionally identify the current user for segment targeting:

```swift
UXRate.identify(userId: "user-123", properties: ["tier": "premium", "plan": "pro"])
```

Call this after login or whenever user context is available. Properties are used by `user_segment` trigger rules.

## Step 3: Track custom events

Track events that your surveys can trigger on:

```swift
UXRate.track(event: "purchase_complete")
UXRate.track(event: "onboarding_finished")
```

Events are batched and sent to the backend automatically.

## Step 4: Mark survey screens

The SDK auto-tracks UIKit view controller names. For **SwiftUI**, add the `.surveyScreen()` modifier to each targetable screen:

```swift
struct CheckoutView: View {
    var body: some View {
        VStack {
            // your content
        }
        .surveyScreen("Checkout")
    }
}
```

The screen name is matched against the `pagePattern` regex in your survey trigger rules. When a match is found, the SDK automatically shows a banner and presents the conversational survey.


<!-- iOS SDK v0.2.0 -->

# Session Replay Configuration

Session replay captures periodic screenshots for visual playback of user sessions. Configuration is server-driven via the `replayConfig` field in each study.

## Quality Presets

| Preset     | FPS | Scale | JPEG Quality | Max Buffer Memory |
|------------|-----|-------|-------------|-------------------|
| `low`      | 1   | 0.4x  | 25%         | 5 MB              |
| `medium`   | 2   | 0.5x  | 35%         | 8 MB              |
| `high`     | 3   | 0.5x  | 45%         | 12 MB             |
| `auto`     | 2*  | 0.5x* | 35%*        | 8 MB*             |

*Auto mode starts at medium and adapts based on upload throughput:
- Upload completes in under 5 seconds: upgrades to `high`
- Upload takes 5 to 15 seconds: stays at `medium`
- Upload takes over 15 seconds: downgrades to `low`

Quality re-evaluation happens every 5 flush cycles, so the SDK converges to the best sustainable quality for the user's connection.

## Capture Scope

- **`off`** -- Replay is disabled for this study.
- **`sampled`** -- Only a percentage of participants are recorded. The `sampleRate` field (1-100 in JSON, converted to 0.0-1.0 internally) controls inclusion. Sampling is deterministic per participant ID, so the same device consistently captures or skips across sessions.
- **`all`** -- Every participant is recorded.

## Trigger Modes

- **`always`** -- Capture starts immediately when the SDK configures.
- **`participants`** -- Same as `always`; capture starts on configure for all sampled participants.
- **`triggered`** -- Capture is armed but deferred. Recording begins only when a matching screen or event trigger fires (defined in `triggerScreens`). Stop triggers (`stopTriggers`) halt capture and flush the buffer.

## Buffer and Flushing

Frames are stored in a circular buffer sized by `bufferSeconds` (default 30) multiplied by the current FPS. The buffer flushes every 30 seconds or when memory usage exceeds the profile limit. On flush failure, the SDK retries with exponential backoff and drops the oldest half of the buffer after 5 consecutive failures.


<!-- END IOS -->

## Android

<!-- BEGIN ANDROID -->
<!-- Android SDK v0.2.0 -->

# API Reference

## UXRate (Singleton)

| Method | Signature | Description |
|--------|-----------|-------------|
| `configure` | `configure(application: Application, apiKey: String, baseURL: String = "https://app.uxrate.com", autoTrackScreens: Boolean = true, useMockService: Boolean = false, overlapStrategy: OverlapStrategy = SHOW_FIRST, theme: SDKTheme = AUTO)` | Initializes the SDK. Call once in `Application.onCreate()`. Fetches survey configuration from the backend asynchronously. |
| `identify` | `identify(userId: String, properties: Map<String, String> = emptyMap())` | Sets the current user ID and properties for segment-based targeting. |
| `track` | `track(event: String, properties: Map<String, String> = emptyMap())` | Tracks a custom event. Re-evaluates trigger rules and enqueues the event for backend submission. |
| `setScreen` | `setScreen(name: String)` | Manually sets the current screen name. Overrides auto-tracking for the current screen. Triggers survey evaluation. |
| `loggingEnabled` | `var loggingEnabled: Boolean` | Enables or disables debug logging to Logcat. Defaults to `false`. |

## Enums

### OverlapStrategy

Controls how the SDK resolves multiple surveys matching the same screen.

| Value | Behavior |
|-------|----------|
| `SHOW_FIRST` | Show the first matching survey in config order (default) |
| `SHOW_LAST` | Show the last matching survey |
| `SHOW_RANDOM` | Randomly pick one matching survey |
| `SHOW_NONE` | Show nothing if multiple surveys match |

### SDKTheme

| Value | Behavior |
|-------|----------|
| `AUTO` | Follow system dark/light setting (default) |
| `LIGHT` | Force light appearance |
| `DARK` | Force dark appearance |

## Compose Helpers

| Component | Usage |
|-----------|-------|
| `NavController.TrackScreens(mapper?)` | Extension function that auto-tracks NavHost route changes. Optional mapper transforms route names. |
| `SurveyScreen(name: String)` | Composable that sets the screen name on appear and clears it on dispose. |


<!-- Android SDK v0.2.0 -->

# Event Tracking

## Custom Events

Track user actions to trigger surveys and build behavioral segments:

```kotlin
UXRate.track(event = "purchase_complete")
UXRate.track(event = "feature_used", properties = mapOf("feature" to "export"))
```

Events are batched in an in-memory queue and flushed to the backend automatically:
- When the queue reaches 50 events
- When an Activity stops (app goes to background)
- On the next session start if a previous flush failed (events are persisted to local storage)

## Screen Tracking

Screen changes are tracked automatically from Activity class names when `autoTrackScreens` is enabled (the default). The `Activity` suffix is stripped (e.g., `CheckoutActivity` becomes `"Checkout"`).

Override the auto-detected name with:

```kotlin
UXRate.setScreen(name = "ProductDetail")
```

In Compose apps, use `navController.TrackScreens()` or the per-screen `SurveyScreen("Name")` composable.

## Lifecycle Events

The SDK tracks these events internally:

| Event name              | When fired                                  |
|-------------------------|---------------------------------------------|
| `uxrate_banner_shown`   | Survey banner overlay becomes visible       |
| `uxrate_banner_tapped`  | User taps the banner call-to-action         |
| `uxrate_chat_opened`    | Survey chat Activity is launched            |
| `uxrate_chat_completed` | User finishes the AI survey conversation    |
| `uxrate_chat_dismissed` | User closes the chat before completing      |

These lifecycle events are sent through the same event queue and can be used in dashboard analytics.

## User Identification

Identify the current user to enable user-segment trigger rules:

```kotlin
UXRate.identify(
    userId = "user-123",
    properties = mapOf("tier" to "premium", "plan" to "pro")
)
```

Properties are stored locally and evaluated against `user_segment` trigger conditions. Call `identify` again to update properties.


<!-- Android SDK v0.2.0 -->

# Installation

## Requirements

- Android API 24+ (Android 7.0 Nougat)
- Kotlin 2.1+
- Jetpack Compose

## Option 1: Gradle (Recommended)

1. Add the UXRate Maven repository to your **project-level** `settings.gradle.kts`:

```kotlin
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://svug-tech.github.io/UXRateSDK") }
    }
}
```

2. Add the dependency to your **module-level** `build.gradle.kts`:

```kotlin
dependencies {
    implementation("com.uxrate:uxrate-sdk:<version>")
}
```

Replace `<version>` with the latest release version. Transitive dependencies (Compose, Coroutines, etc.) are resolved automatically. No authentication required.

## Option 2: Manual AAR Download

1. Download the latest `uxrate-sdk-<version>.aar` from [Releases](https://github.com/SVUG-Tech/UXRateSDK/releases).
2. Copy the AAR into your module's `libs/` directory.
3. Add the `flatDir` repository and dependency:

**settings.gradle.kts** (project-level):
```kotlin
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        flatDir { dirs("libs") }
    }
}
```

**build.gradle.kts** (module-level):
```kotlin
dependencies {
    implementation(files("libs/uxrate-sdk-<version>.aar"))

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

With the Gradle approach transitive dependencies are resolved automatically. With the AAR download you must declare them manually.


<!-- Android SDK v0.2.0 -->

# Quick Start

Get UXRate running in four steps.

## Step 1: Configure in Application.onCreate()

Create (or update) your `Application` subclass and register it in `AndroidManifest.xml`:

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
            apiKey = "uxr_your_api_key"
        )
    }
}
```

## Step 2: Identify the User

Call `identify` once the user is known (e.g., after login):

```kotlin
UXRate.identify(
    userId = "user-123",
    properties = mapOf("tier" to "premium", "plan" to "pro")
)
```

Properties are used for user-segment trigger rules configured in the dashboard.

## Step 3: Track Events

Track custom events to trigger surveys based on user actions:

```kotlin
UXRate.track(event = "purchase_complete")
UXRate.track(event = "feature_used", properties = mapOf("feature" to "export"))
```

## Step 4: Screen Tracking

**Automatic (Activity-based):** Screen names are derived from Activity class names by default (e.g., `HomeActivity` becomes `"Home"`). No code needed.

**Manual override:** Set the screen name explicitly when auto-detection is not sufficient:

```kotlin
UXRate.setScreen(name = "Checkout")
```

**Jetpack Compose with NavHost:** Use `TrackScreens()` on your `NavController` to auto-track route changes:

```kotlin
import com.uxrate.sdk.ui.TrackScreens

val navController = rememberNavController()
navController.TrackScreens()

NavHost(navController, startDestination = "home") {
    composable("home") { HomeScreen() }
    composable("profile") { ProfileScreen() }
}
```

**Per-screen Composable:** Wrap individual screens with `SurveyScreen()`:

```kotlin
import com.uxrate.sdk.ui.SurveyScreen

@Composable
fun HomeScreen() {
    SurveyScreen("Home")
}
```


<!-- Android SDK v0.2.0 -->

# Session Replay Configuration

## Quality Presets

| Preset   | Frame interval | Scale | JPEG quality | Buffer memory | Max frames |
|----------|---------------|-------|-------------|---------------|------------|
| `low`    | 1000 ms       | 0.4x  | 25          | 5 MB          | 1800       |
| `medium` | 500 ms        | 0.5x  | 35          | 8 MB          | 3600       |
| `high`   | 333 ms        | 0.5x  | 45          | 12 MB         | 5400       |
| `auto`   | starts medium | adaptive | adaptive | adaptive    | adaptive   |

## Auto Mode

When quality is set to `"auto"` (the default), the SDK starts at MEDIUM and adapts based on upload performance. Every 5 flush cycles the SDK measures the average upload duration:

- Average < 5 seconds: upgrades to HIGH
- Average 5-15 seconds: stays at MEDIUM
- Average > 15 seconds: downgrades to LOW

This keeps replay quality as high as possible without degrading the user's network experience.

## Scope

- `"off"` -- Replay capture is disabled.
- `"sampled"` -- Only a percentage of participants are recorded, controlled by `sampleRate` (0-100 on the dashboard, converted to 0.0-1.0 internally). Sampling is deterministic per participant ID.
- `"all"` -- Every participant is recorded.

## Trigger Modes

- `"always"` -- Capture starts immediately on app launch.
- `"participants"` -- Capture starts for sampled or all participants after configuration.
- `"triggered"` -- Capture is armed but deferred. Recording begins only when a matching screen or event trigger fires. Trigger screens and events are configured via `triggerScreens` in the dashboard.

## Stop Triggers

Configure `stopTriggers` to automatically stop recording when a specific screen is visited or event fires. Useful for ending capture after a checkout flow or sensitive screen.

## Buffer and Flush

Frames are buffered in memory and flushed to the server every 30 seconds, on app background, and when buffer memory exceeds the quality profile limit. On upload failure the SDK retries with exponential backoff and drops the oldest half of frames after 5 consecutive failures.


<!-- END ANDROID -->

## Flutter

<!-- BEGIN FLUTTER -->
# API Reference

All methods are static and live on the `UXRate` class. Import with:

```dart
import 'package:flutter_uxrate/flutter_uxrate.dart';
```

## Methods

| Method | Description |
|--------|-------------|
| [`configure`](#configure) | Initialise the SDK. Must be called before any other method. |
| [`identify`](#identify) | Associate the current session with a user. |
| [`track`](#track) | Record a custom event. |
| [`setScreen`](#setscreen) | Report the current screen name. |

---

### configure

```dart
static Future<void> configure({
  required String apiKey,
  bool autoTrackScreens = false,
  bool useMockService = false,
})
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `apiKey` | `String` | *required* | Your UXRate API key. |
| `autoTrackScreens` | `bool` | `false` | Auto-detect screen changes via native swizzle. Usually `false` for Flutter because the app runs in a single native view. |
| `useMockService` | `bool` | `false` | Use the built-in mock backend for testing. |

---

### identify

```dart
static Future<void> identify({
  required String userId,
  Map<String, String> properties = const {},
})
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `userId` | `String` | *required* | Stable identifier for the user. |
| `properties` | `Map<String, String>` | `{}` | Key-value pairs for segment targeting (e.g. `{'plan': 'pro'}`). |

---

### track

```dart
static Future<void> track({required String event})
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `event` | `String` | *required* | Name of the event to record. |

---

### setScreen

```dart
static Future<void> setScreen(String name)
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `name` | `String` | *required* | Name of the current screen. |


# Event Tracking

## Custom events

Use `UXRate.track` to record any user action. Events are counted locally and
evaluated against trigger rules defined on the UXRate dashboard.

```dart
// Track a single event
await UXRate.track(event: 'add_to_cart');
```

Common event examples:

| Event name          | When to fire                     |
|---------------------|----------------------------------|
| `sign_up`           | User completes registration      |
| `purchase_complete` | User finishes checkout           |
| `feature_used`      | User interacts with a key feature|
| `error_encountered` | An error dialog is shown         |

## Screen tracking

### Manual tracking

Call `setScreen` in each screen's `initState`:

```dart
@override
void initState() {
  super.initState();
  UXRate.setScreen('ProductDetail');
}
```

### NavigatorObserver

For apps using `Navigator`, create an observer to track every route push:

```dart
class UXRateObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    final name = route.settings.name;
    if (name != null) {
      UXRate.setScreen(name);
    }
  }
}

// Register it:
MaterialApp(
  navigatorObservers: [UXRateObserver()],
  // ...
);
```

### GoRouter integration

If you use `go_router`, attach the observer via `GoRouter.observers`:

```dart
final router = GoRouter(
  observers: [UXRateObserver()],
  routes: [
    GoRoute(path: '/', name: 'home', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/products', name: 'products', builder: (_, __) => const ProductsScreen()),
  ],
);
```

## Best practices

- Use lowercase, snake_case event names for consistency.
- Keep event names stable across releases so dashboard rules don't break.
- Avoid high-frequency events (e.g., scroll) -- they inflate local storage.


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


# Quick Start

Get UXRate running in your Flutter app in four steps.

## 1. Configure the SDK

Call `UXRate.configure` once at app startup, **before** `runApp()`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_uxrate/flutter_uxrate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UXRate.configure(apiKey: 'YOUR_API_KEY');
  runApp(const MyApp());
}
```

## 2. Identify the user

Call `identify` after the user logs in (or as soon as you know who they are):

```dart
await UXRate.identify(
  userId: 'user-42',
  properties: {'plan': 'pro', 'company': 'Acme'},
);
```

## 3. Track events

Fire custom events whenever something meaningful happens:

```dart
await UXRate.track(event: 'purchase_complete');
```

## 4. Set the current screen

Flutter runs inside a single native view, so auto screen detection does not
distinguish between Flutter routes. Report screens manually:

```dart
@override
void initState() {
  super.initState();
  UXRate.setScreen('Checkout');
}
```

Or use a `NavigatorObserver` for automatic route-level tracking:

```dart
class UXRateObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      UXRate.setScreen(route.settings.name!);
    }
  }
}
```

---

That's it. Surveys are configured on the UXRate dashboard and delivered
automatically when trigger conditions are met.


# Session Replay Configuration

## Overview

Session replay captures user interactions so you can watch how users navigate
your app. In the Flutter plugin, replay is handled entirely by the **native
iOS and Android UXRate SDKs** -- there is no Dart-level API for replay.

## How it works

1. The native SDK records touches, gestures, and screen transitions.
2. Recordings are uploaded to the UXRate backend.
3. You view replays in the UXRate dashboard.

## Configuration

All replay settings are managed from the **UXRate dashboard**:

- **Enable / disable** replay per project.
- **Sampling rate** -- control what percentage of sessions are recorded.
- **Masking rules** -- mark sensitive fields so their content is hidden in
  recordings.
- **Max session length** -- cap the duration of a single recording.

No code changes are required in your Flutter app to configure replay. If
you need to adjust settings, log in to the dashboard at
<https://app-dev.uxrate.com>.

## Privacy

- Text fields marked as `secureTextEntry` (iOS) or `inputType="textPassword"`
  (Android) are automatically masked.
- Additional masking can be configured in the dashboard.
- Replay respects the user's device-level screen recording permissions.


<!-- END FLUTTER -->

## React Native

<!-- BEGIN REACT_NATIVE -->
# API Reference

All methods are available on the `UXRate` export:

```tsx
import { UXRate } from 'react-native-uxrate';
```

## Methods

| Method | Description |
|--------|-------------|
| `configure(options)` | Initialise the SDK. Call once at app startup. |
| `identify(options)` | Identify the current user for survey targeting. |
| `track(options)` | Record a custom event. |
| `setScreen(name)` | Report the current screen name. |

All methods return `Promise<void>`.

---

### `configure(options: ConfigureOptions): Promise<void>`

```ts
interface ConfigureOptions {
  apiKey: string;
  autoTrackScreens?: boolean; // default: false
  useMockService?: boolean;   // default: false
}
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `apiKey` | `string` | Yes | Your UXRate API key. |
| `autoTrackScreens` | `boolean` | No | Enable native auto screen tracking. In React Native apps manual `setScreen` calls are preferred. |
| `useMockService` | `boolean` | No | Use the built-in mock backend for local testing. |

---

### `identify(options: IdentifyOptions): Promise<void>`

```ts
interface IdentifyOptions {
  userId: string;
  properties?: Record<string, string>;
}
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `userId` | `string` | Yes | A stable user identifier. |
| `properties` | `Record<string, string>` | No | Key-value properties for segment targeting. |

---

### `track(options: TrackOptions): Promise<void>`

```ts
interface TrackOptions {
  event: string;
}
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event` | `string` | Yes | The event name to record. |

---

### `setScreen(name: string): Promise<void>`

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | `string` | Yes | The screen name to report. |

## TypeScript

Full type definitions are shipped with the package in `index.d.ts`.


# Event Tracking

## Custom events

Use `UXRate.track` to record events that can trigger surveys:

```tsx
UXRate.track({ event: 'purchase_complete' });
UXRate.track({ event: 'onboarding_finished' });
```

Event names are arbitrary strings. Define matching trigger rules in the UXRate
dashboard to show a survey when a specific event fires.

## Screen tracking

React Native apps run inside a single native ViewController (iOS) or Activity
(Android), so the native auto-track feature sees only one screen. You should
report screens manually using `setScreen`.

### Per-screen tracking with `useFocusEffect`

```tsx
import { useFocusEffect } from '@react-navigation/native';
import { UXRate } from 'react-native-uxrate';

function SettingsScreen() {
  useFocusEffect(() => {
    UXRate.setScreen('Settings');
  });

  return <View>...</View>;
}
```

### Global tracking with React Navigation

You can report every navigation change from a single place:

```tsx
import { NavigationContainer } from '@react-navigation/native';

<NavigationContainer
  onStateChange={(state) => {
    const route = state?.routes[state.index];
    if (route) UXRate.setScreen(route.name);
  }}
>
  {/* screens */}
</NavigationContainer>
```

See the [React Navigation integration tutorial](../tutorials/react-navigation-integration.md) for a full walkthrough.

## Best practices

- Keep event names short and consistent (e.g. `snake_case`).
- Report screens as early as possible so survey targeting is accurate.
- Avoid tracking high-frequency events (e.g. scroll positions) -- they add
  noise without improving targeting.


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


# Quick Start

Get UXRate running in your React Native app in four steps.

## 1. Configure the SDK

Call `configure` once at app startup, typically in your root `App.tsx`:

```tsx
import { UXRate } from 'react-native-uxrate';

useEffect(() => {
  UXRate.configure({ apiKey: 'YOUR_API_KEY' });
}, []);
```

## 2. Identify the user

After your user signs in, call `identify` so surveys can be targeted:

```tsx
UXRate.identify({
  userId: 'user-42',
  properties: { plan: 'pro', company: 'Acme' },
});
```

## 3. Track events

Fire custom events that can trigger surveys:

```tsx
UXRate.track({ event: 'checkout_complete' });
```

## 4. Report screen names

React Native runs inside a single native view controller / activity, so
automatic screen tracking will not distinguish between JS routes. Use
`setScreen` on each navigation change:

```tsx
<NavigationContainer
  onStateChange={(state) => {
    const route = state?.routes[state.index];
    if (route) UXRate.setScreen(route.name);
  }}
>
```

That's it -- surveys configured in the UXRate dashboard will now appear to
your users based on events, screens, and segments you define.


# Session Replay Configuration

## Overview

Session replay is handled entirely by the native UXRate SDKs (iOS and Android).
The React Native module does not expose separate replay APIs -- replay capture
is started automatically by the native SDK when it is enabled for your project.

## Enabling replay

1. Open the UXRate dashboard.
2. Navigate to your project settings.
3. Toggle **Session Replay** on.
4. Configure the desired sampling rate and privacy masking options.

Once enabled on the dashboard the native SDKs begin capturing replay data
without any additional code changes in your React Native app.

## Privacy masking

Sensitive views can be masked from replays. Masking rules are configured in
the UXRate dashboard and applied at the native layer. Because React Native
renders through native view hierarchies, the standard masking rules apply
to RN-rendered content as well.

## Troubleshooting

- **Replay not appearing**: Make sure the native SDK versions match the
  minimum required for replay support (check the native SDK changelogs).
- **Missing frames**: Replay capture runs at a reduced frame rate to minimise
  performance impact. Short interactions may not produce visible frames.
- **Large payload warnings**: If your app has complex view hierarchies,
  consider increasing the masking scope to reduce payload size.


<!-- END REACT_NATIVE -->

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
