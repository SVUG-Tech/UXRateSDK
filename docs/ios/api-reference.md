<!-- iOS SDK v0.8.0 -->

# API Reference

All public API methods are static methods on the `UXRate` enum.

| Method | Signature | Description |
|--------|-----------|-------------|
| `configure` | `configure(apiKey:autoTrackScreens:mockScreens:overlapStrategy:theme:)` | Initializes the SDK. Call once at app launch. The backend is auto-resolved from the `apiKey` prefix (`uxr_…` → production, `uxr_dev_…` → dev, `uxr_loc_…` → local). Pass `apiKey: "mock"` to use the in-memory mock service. `autoTrackScreens` (default `true`) swizzles UIViewController for automatic screen detection. `mockScreens` (optional) specifies which screens trigger mock surveys. `overlapStrategy` (default `.showFirst`) controls how multiple matching surveys are resolved. `theme` (default `.auto`) sets the color scheme for all SDK UI. |
| `identify` | `identify(userId:properties:)` | Sets the current user ID and optional properties for segment targeting. Properties are merged with any previously set values. |
| `track` | `track(event:properties:)` | Tracks a custom event by name. Increments the local event count (used by `event` trigger rules) and enqueues the event for batch delivery. |
| `setScreen` | `setScreen(_:)` | Manually sets the current screen name. Overrides the auto-detected UIViewController class name. Required for SwiftUI screens when not using `.surveyScreen()`. |
| `loggingEnabled` | `loggingEnabled: Bool` | Static property that controls debug console output. Defaults to `true` in DEBUG builds, `false` in release. Set before calling `configure` to silence all SDK logs. |
| `onBannerWillShow` | `onBannerWillShow: ((_ studyId: String, _ screenName: String, _ completion: @escaping (Bool) -> Void) -> Void)?` | Called before a banner is shown. Call `completion(true)` to allow, `completion(false)` to suppress. 2-second safety timeout defaults to show. |
| `hideBanner` | `hideBanner()` | Programmatically hides the visible banner without tracking a dismiss event. |

## View Modifiers

| Modifier | Description |
|----------|-------------|
| `.surveyScreen(_ name: String)` | Marks a SwiftUI view as a targetable survey screen. The name is matched against `pagePattern` regex in trigger rules. Tracks the screen once per view lifecycle. |
