# SDK Overview

## Integration Pattern

Every UXRate integration follows the same four steps:

1. **Configure** — Initialize the SDK with your API key at app startup. This fetches survey configuration from the backend.
2. **Identify** — Associate the session with a user ID and properties (e.g., plan, tier) for segment-based targeting.
3. **Track** — Record custom events (e.g., `purchase_complete`) that surveys can trigger on.
4. **Set Screen** — Report screen names so surveys can target specific screens.

Once set up, surveys are delivered automatically based on trigger rules you configure in the dashboard.

## Common Parameters

| Parameter | Description |
|-----------|-------------|
| `apiKey` | Your UXRate API key (starts with `uxr_`). Required. |
| `autoTrackScreens` | Auto-detect screen changes from native view controllers / activities. Defaults to `true` on iOS/Android, `false` on Flutter/React Native (since they run in a single native view). |
| `useMockService` | Use a built-in mock backend for development and testing. |
| `overlapStrategy` | How to resolve multiple surveys matching the same screen: show first, last, random, or none. |
| `theme` | SDK UI color scheme: auto (follows system), light, or dark. |
