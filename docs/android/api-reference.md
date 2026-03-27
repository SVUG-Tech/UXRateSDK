<!-- Android SDK v0.2.1 -->

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
