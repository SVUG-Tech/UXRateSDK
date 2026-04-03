# Quick Start

Get UXRate running in your Flutter app in four steps.

## 1. Configure the SDK

Call `UXRate.configure` once at app startup, **before** `runApp()`:

**Quick test with mock surveys (no backend needed):**

```dart
await UXRate.configure(apiKey: 'YOUR_API_KEY', environment: 'mock');
```

**Production:**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_uxrate/flutter_uxrate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UXRate.configure(apiKey: 'uxr_your_api_key');
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
