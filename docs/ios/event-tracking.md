<!-- iOS SDK v0.2.0 -->

# Event Tracking

UXRateSDK tracks three categories of events: custom events, screen views, and SDK lifecycle events.

## Custom Events

Track user actions that surveys can trigger on:

```swift
UXRate.track(event: "purchase_complete")
UXRate.track(event: "item_added_to_cart", properties: ["category": "electronics"])
```

Each call increments the event's local count and enqueues it for batch delivery. The `event` trigger rule type matches against event names and counts.

## Screen Tracking

**UIKit (automatic):** The SDK swizzles `UIViewController.viewDidAppear` to detect screen names from class names. Override the auto-detected name with:

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UXRate.setScreen("Checkout")
}
```

**SwiftUI (manual):** Add the `.surveyScreen()` modifier to each targetable view:

```swift
ContentView()
    .surveyScreen("Home")
```

Screen visits are counted locally and matched against `page_visit` trigger rules using regex patterns.

## SDK Lifecycle Events

The SDK automatically tracks these events internally. They are delivered to the backend as part of the event batch and are visible in the UXRate dashboard:

| Event Name                 | When Fired                                         |
|----------------------------|-----------------------------------------------------|
| `uxrate_banner_shown`      | A survey banner is displayed to the user            |
| `uxrate_survey_started`    | The user opens the conversational survey            |
| `uxrate_survey_closed`     | The user dismisses the survey without completing it |
| `uxrate_survey_completed`  | The backend signals the interview is finished       |

These events are tracked automatically and do not need to be called manually.
