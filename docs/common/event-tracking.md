# Event Tracking

UXRateSDK tracks three categories of events: **custom events**, **screen views**, and **lifecycle events**. Events are used to trigger surveys and build behavioral segments.

## Custom Events

Track meaningful user actions (e.g., `purchase_complete`, `feature_used`). Each event increments a local counter that survey trigger rules evaluate. Events are batched and sent to the backend automatically.

**Best practices:**
- Use lowercase `snake_case` names for consistency.
- Keep names stable across releases so dashboard rules don't break.
- Avoid high-frequency events (e.g., scroll positions) — they add noise without improving targeting.

## Screen Tracking

Screen visits are counted and matched against `page_visit` trigger rules using regex patterns. When a pattern matches, the SDK can show a survey on that screen.

- **iOS**: Auto-detects UIKit view controllers. For SwiftUI, use `.surveyScreen("Name")`.
- **Android**: Auto-detects Activity class names. For Compose, use `TrackScreens()` or `SurveyScreen("Name")`.
- **Flutter / React Native**: Run inside a single native view, so auto-detection doesn't distinguish routes. Use `setScreen()` manually or via a NavigatorObserver / navigation listener.

## Lifecycle Events

The SDK automatically tracks internal events like `uxrate_banner_shown`, `uxrate_survey_started`, and `uxrate_survey_completed`. These appear in your dashboard analytics. Exact event names vary slightly by platform — see the platform API reference for details.

## User Identification

Call `identify(userId, properties)` after login to enable user-segment targeting. Properties (e.g., `tier: "premium"`) are evaluated against segment trigger rules in the dashboard.
