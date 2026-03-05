# UXRateSDK Integration Guide

## Requirements

- iOS 17.0+ / macOS 14.0+
- Swift 6.0+
- SwiftUI

---

## Installation

### Swift Package Manager — Local

1. Copy the `UXRateSDK` folder into your project's root directory.
2. In Xcode, go to your project settings → **Package Dependencies** → click **+**.
3. Select **Add Local…** and choose the `UXRateSDK` directory.
4. Add `UXRateSDK` to your app target.

### Swift Package Manager — Remote

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/SVUG-Tech/UXRateSDK.git", from: "0.1.0")
]
```

Then add `"UXRateSDK"` to your target's dependencies.

---

## iOS / SwiftUI Integration

One call in `App.init()`. The SDK auto-attaches a transparent overlay window and handles banner display and chat presentation.

```swift
import SwiftUI
import UXRateSDK

@main
struct MyApp: App {
    init() {
        UXRate.configure(apiKey: "uxr_xxx")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### Screen Tracking

Pure SwiftUI apps use `NavigationStack` and `TabView`, which internally wrap views in hosting controllers with type-erased `AnyView`. The SDK cannot auto-detect screen names in this case — **add `.surveyScreen("Name")` to each screen you want to target with surveys:**

```swift
struct HomeView: View {
    var body: some View {
        NavigationStack {
            List { /* … */ }
                .surveyScreen("Home")
                .navigationTitle("Home")
        }
    }
}
```

The modifier fires once per view lifecycle (first appear only) — state changes and re-renders do not trigger extra visit counts.

> **Tip:** Place `.surveyScreen()` on the content _inside_ `NavigationStack`, not on the stack itself. This ensures the screen name is re-reported correctly when navigating back.

### UIKit Apps Embedding SwiftUI

If your UIKit app pushes SwiftUI views via `UIHostingController(rootView: MyView())`, the SDK auto-detects the screen name from the concrete generic type (e.g. `"MyView"`). No `.surveyScreen()` needed in this case — it works like UIKit auto-tracking.

---

## iOS / UIKit Integration

```swift
import UIKit
import UXRateSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UXRate.configure(apiKey: "uxr_xxx")
        return true
    }
}
```

### Screen Name Override

The SDK infers the screen name from the view controller's class name (e.g. `"CheckoutViewController"`). Override it with `UXRate.setScreen(_:)` from `viewDidAppear`:

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UXRate.setScreen("Checkout")   // replaces "CheckoutViewController" — no double-counting
}
```

You can also disable automatic screen tracking and track screens entirely manually:

```swift
UXRate.configure(apiKey: "uxr_xxx", autoTrackScreens: false)
```

When `autoTrackScreens` is `false`, no view controller swizzle is installed — use `UXRate.setScreen(_:)` in every view controller's `viewDidAppear`.

---

## User Identification

Call `identify` after the user signs in, or whenever their identity is known:

```swift
UXRate.identify(userId: "user-123", properties: ["plan": "pro", "locale": "en-US"])
```

- `userId` — stable identifier (e.g. database ID or UUID).
- `properties` — optional `[String: String]` attributes used in `user_segment` trigger rules.

---

## Event Tracking

```swift
UXRate.track(event: "purchase_complete")
```

Tracked events can be used in `event`-type trigger rules (see Trigger Rules below).

---

## Logging

By default the SDK prints debug messages in `DEBUG` builds and is silent in release builds. Override any time:

```swift
UXRate.loggingEnabled = false   // silence even in DEBUG
UXRate.loggingEnabled = true    // enable even in RELEASE (e.g. for QA builds)
```

---

## Trigger Rules Reference

Surveys are shown based on rules configured in the UXRate dashboard. The SDK evaluates these rules whenever a screen is reported or an event is tracked.

| Rule type | Key conditions |
|---|---|
| `page_visit` | `pagePattern` (regex matched against screen name), `visitCount` |
| `event` | `eventName`, `count` (number of times the event must have fired) |
| `time_based` | `daysAfterInstall` |
| `user_segment` | `property` (key in `identify` properties), `value` |

---

## Development & Testing

Use `useMockService: true` to get a local mock survey response without a real API key or network connection:

```swift
UXRate.configure(apiKey: "demo", useMockService: true)
```

The mock service returns a canned survey that triggers on any screen, so you can verify the full UI flow immediately.

---

## Flutter Plugin (`flutter_uxrate`)

> **Runnable demo app:** `flutter_uxrate/example/` — open in VS Code or Android Studio, run `flutter pub get`, then `flutter run` on an iOS simulator.

### Installation

```yaml
# pubspec.yaml
dependencies:
  flutter_uxrate:
    path: ../flutter_uxrate   # local; replace with pub.dev path for distribution
```

Run `flutter pub get` after adding the dependency.

### Setup

Call `UXRate.configure` before `runApp`, then `UXRate.identify` once the user is known:

```dart
import 'package:flutter_uxrate/flutter_uxrate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UXRate.configure(apiKey: 'uxr_xxx', useMockService: false);
  await UXRate.identify(userId: 'user-123', properties: {'plan': 'pro'});
  runApp(const MyApp());
}
```

### Screen Tracking

Flutter runs inside a single `FlutterViewController`, so `autoTrackScreens` cannot distinguish between Dart routes. **Always use manual `UXRate.setScreen` calls.**

The recommended place is `initState` of each `StatefulWidget` screen:

```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Called once when this screen is first built.
    UXRate.setScreen('Home');
  }

  @override
  Widget build(BuildContext context) { /* … */ }
}
```

For screens in a bottom tab bar that stay alive (using `IndexedStack`), `initState` fires only on first creation. If you need to re-report the screen every time the user switches back to the tab, use a `TabController` listener or override `didChangeDependencies`.

With **GoRouter**, add the call in each route's `builder`:

```dart
GoRoute(
  path: '/home',
  builder: (context, state) {
    UXRate.setScreen('Home');
    return const HomeScreen();
  },
),
```

### User Identification

```dart
await UXRate.identify(userId: 'user-123', properties: {'plan': 'pro'});
```

### Event Tracking

```dart
await UXRate.track(event: 'purchase_complete');
```

---

## React Native Plugin (`react-native-uxrate`)

> **Runnable demo app:** `react-native-uxrate/example/` — run `npm install && cd ios && pod install && cd .. && npx react-native run-ios` to launch on the iOS simulator.

### Installation

```sh
npm install react-native-uxrate
cd ios && pod install
```

### Setup

Call `UXRate.configure` once at app startup and `UXRate.identify` after the user is known:

```tsx
import { UXRate } from 'react-native-uxrate';

export default function App() {
  useEffect(() => {
    UXRate.configure({ apiKey: 'uxr_xxx' });
    UXRate.identify({ userId: 'user-123', properties: { plan: 'pro' } });
  }, []);

  return <NavigationContainer>{/* … */}</NavigationContainer>;
}
```

### Screen Tracking

React Native runs inside a single `RCTRootViewController`, so `autoTrackScreens` cannot distinguish between JS screens. **Always use manual `UXRate.setScreen` calls.**

**Per-screen with `useFocusEffect` (recommended):**

`useFocusEffect` (from `@react-navigation/native`) fires every time a screen comes into focus — including when the user navigates back to it. This makes it the most reliable pattern:

```tsx
import { useFocusEffect } from '@react-navigation/native';
import { UXRate } from 'react-native-uxrate';

export default function HomeScreen() {
  useFocusEffect(
    useCallback(() => {
      UXRate.setScreen('Home');
    }, []),
  );

  return /* … */;
}
```

**Global with `NavigationContainer.onStateChange` (alternative):**

Use this if you want a single tracking point rather than per-screen calls:

```tsx
function getActiveRouteName(state: NavigationState | undefined): string | undefined {
  if (!state) return undefined;
  const route = state.routes[state.index];
  if (route.state) return getActiveRouteName(route.state as NavigationState);
  return route.name;
}

<NavigationContainer
  onStateChange={(state) => {
    const name = getActiveRouteName(state);
    if (name) UXRate.setScreen(name);
  }}
>
  {/* … */}
</NavigationContainer>
```

### User Identification

```js
UXRate.identify({ userId: 'user-123', properties: { plan: 'pro' } });
```

### Event Tracking

```js
UXRate.track({ event: 'purchase_complete' });
```

---

## Troubleshooting

**Survey banner not appearing**
- Enable logging (`UXRate.loggingEnabled = true`) — the SDK prints the screen name it reports on every navigation. Check that it matches the `pagePattern` regex in your dashboard rule.
- Check the daily cap in your dashboard rule; surveys won't re-appear once the cap is reached for the day.

**Wrong screen name auto-detected (UIKit)**
- Use `UXRate.setScreen("Name")` in `viewDidAppear` to override the auto-detected VC class name.

**Screen not detected in SwiftUI**
- Add `.surveyScreen("Name")` to the content view inside your `NavigationStack`. Pure SwiftUI apps cannot auto-detect screen names.

**Banner visible on every screen in mock mode**
- Expected behaviour: `useMockService: true` returns a rule that matches all screens. Switch to a real API key when you want rule-filtered display.
