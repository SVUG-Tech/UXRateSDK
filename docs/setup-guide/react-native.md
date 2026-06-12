# React Native

## Requirements

`iOS 17.0+` · `Android 7.0+ (API 24)` · `React Native 0.72+`

## Step 1 — Install the SDK

```bash
npm install react-native-uxrate
```

On iOS, also install native pods:

```bash
cd ios && pod install && cd ..
```

> 💡 A single `react-native-uxrate` installation covers both iOS and Android via auto-linking — no separate Android setup is required.

## Step 2 — Initialize the SDK

Configure in your app entry point. The backend is auto-resolved from the API key prefix (`uxr_…` → production, `uxr_dev_…` → development).

```javascript
import { UXRate } from 'react-native-uxrate';

useEffect(() => {
  UXRate.configure({ apiKey: 'YOUR_API_KEY' });
}, []);
```

> ⚠️ **Important:** Replace `YOUR_API_KEY` with the key from your UXRate dashboard (Application → API Keys). Use a `uxr_dev_…` key against the development environment while testing.

## Step 3 — Identify users

```javascript
await UXRate.identify({
  userId: 'user-123',
  properties: {
    plan: 'pro',
    signup_date: '2025-01-15',
  },
});
```

> ℹ️ The `userId` is stored as the participant identifier on every interview this user completes. The `properties` object powers `user_segment` trigger rules.

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

```javascript
UXRate.track({ event: 'purchase_complete' });
UXRate.track({ event: 'onboarding_skipped' });
UXRate.track({ event: 'cart_abandoned' });
```

## Step 6 — Track screens

React Native runs inside a single native view, so the SDK cannot auto-detect screen names. Use `useFocusEffect` so the screen is reported every time it comes into focus (including back navigation):

```javascript
import { useFocusEffect } from '@react-navigation/native';
import { useCallback } from 'react';

export default function CheckoutScreen() {
  useFocusEffect(
    useCallback(() => {
      UXRate.setScreen('Checkout');
    }, []),
  );

  return /* ... */;
}
```

## Step 7 — Verify

Run the app with a `uxr_dev_…` key, create a study with a trigger rule in the dashboard, and navigate to the matching screen — the banner should appear. You can also start a test interview from the Studies page.
