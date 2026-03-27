<!-- iOS SDK v0.2.1 -->

# Event Tracking — iOS

> For concepts and best practices, see [Event Tracking](Event-Tracking).

## Custom Events

```swift
UXRate.track(event: "purchase_complete")
UXRate.track(event: "item_added_to_cart", properties: ["category": "electronics"])
```

## Screen Tracking

**UIKit (automatic):** The SDK swizzles `UIViewController.viewDidAppear` to detect screen names from class names. Override with:

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UXRate.setScreen("Checkout")
}
```

**SwiftUI (manual):** Add the `.surveyScreen()` modifier:

```swift
ContentView()
    .surveyScreen("Home")
```

## Lifecycle Events

| Event Name                 | When Fired                                         |
|----------------------------|-----------------------------------------------------|
| `uxrate_banner_shown`      | A survey banner is displayed to the user            |
| `uxrate_survey_started`    | The user opens the conversational survey            |
| `uxrate_survey_closed`     | The user dismisses the survey without completing it |
| `uxrate_survey_completed`  | The backend signals the interview is finished       |
