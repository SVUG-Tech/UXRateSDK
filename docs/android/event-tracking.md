<!-- Android SDK v0.8.0 -->

# Event Tracking — Android

> For concepts and best practices, see [Event Tracking](Event-Tracking).

## Custom Events

```kotlin
UXRate.track(event = "purchase_complete")
UXRate.track(event = "feature_used", properties = mapOf("feature" to "export"))
```

## Screen Tracking

**Automatic:** Activity class names are tracked when `autoTrackScreens` is enabled (the default). The `Activity` suffix is stripped (e.g., `CheckoutActivity` → `"Checkout"`).

**Manual override:**

```kotlin
UXRate.setScreen(name = "ProductDetail")
```

**Compose:** Use `navController.TrackScreens()` or per-screen `SurveyScreen("Name")`.

## User Identification

```kotlin
UXRate.identify(
    userId = "user-123",
    properties = mapOf("tier" to "premium", "plan" to "pro")
)
```

## Lifecycle Events

| Event Name              | When Fired                                  |
|-------------------------|---------------------------------------------|
| `uxrate_banner_shown`   | Survey banner overlay becomes visible       |
| `uxrate_banner_tapped`  | User taps the banner call-to-action         |
| `uxrate_chat_opened`    | Survey chat Activity is launched            |
| `uxrate_chat_completed` | User finishes the AI survey conversation    |
| `uxrate_chat_dismissed` | User closes the chat before completing      |
