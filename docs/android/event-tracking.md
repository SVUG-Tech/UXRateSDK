<!-- Android SDK v0.2.1 -->

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
