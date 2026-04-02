<!-- iOS SDK v0.2.2 -->

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
