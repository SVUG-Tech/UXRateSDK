# Flutter

## Requirements

`iOS 17.0+` · `Android 7.0+ (API 24)` · `Flutter 3.x+`

## Step 1 — Install the SDK

Add the package to your `pubspec.yaml`, then run `flutter pub get`:

```yaml
dependencies:
  flutter_uxrate: ^0.9.0
```

On iOS, also install native pods:

```bash
cd ios && pod install && cd ..
```

> 💡 A single `flutter_uxrate` installation covers both iOS and Android — no separate Android setup is required.

## Step 2 — Initialize the SDK

Configure before `runApp()`. The backend is auto-resolved from the API key prefix (`uxr_…` → production, `uxr_dev_…` → development).

```dart
import 'package:flutter_uxrate/flutter_uxrate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UXRate.configure(apiKey: 'YOUR_API_KEY');
  runApp(MyApp());
}
```

> ⚠️ **Important:** Replace `YOUR_API_KEY` with the key from your UXRate dashboard (Application → API Keys). Use a `uxr_dev_…` key against the development environment while testing.

## Step 3 — Identify users

```dart
await UXRate.identify(
  userId: 'user-123',
  properties: {
    'plan': 'pro',
    'signup_date': '2025-01-15',
  },
);
```

> ℹ️ The `userId` is stored as the participant identifier on every interview this user completes. The `properties` map powers `user_segment` trigger rules.

## Step 4 — Trigger rules

Interviews fire automatically when the SDK detects a matching rule configured in the dashboard:

| Rule | Fires when |
|------|------------|
| `page_visit` | A user visits a screen matching a name pattern (Step 6 tracking) |
| `event` | A specific event fires N times (Step 5 tracking) |
| `time_based` | N days have passed since app install |
| `user_segment` | The user has a specific `identify()` property value |

When multiple studies match the same screen, the **highest-priority** study (set in the panel) is shown; ties go to the newest study.

## Step 5 — Track events

```dart
await UXRate.track(event: 'purchase_complete');
await UXRate.track(event: 'onboarding_skipped');
await UXRate.track(event: 'cart_abandoned');
```

## Step 6 — Track screens

Flutter runs inside a single native view, so the SDK cannot auto-detect screen names. Call `setScreen()` in each screen's `initState` (for GoRouter, call it inside the route's `builder`):

```dart
@override
void initState() {
  super.initState();
  UXRate.setScreen('Checkout');
}
```

## Step 7 — Verify

Run the app with a `uxr_dev_…` key, create a study with a trigger rule in the dashboard, and navigate to the matching screen — the banner should appear. You can also start a test interview from the Studies page.
