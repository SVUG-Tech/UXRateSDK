# iOS

## Requirements

`iOS 17.0+` · `Xcode 16+` · `Swift 6.0+`

## Step 1 — Install the SDK

**Swift Package Manager** — in Xcode: **File → Add Package Dependencies** → paste:

```url
https://github.com/SVUG-Tech/UXRateSDK.git
```

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/SVUG-Tech/UXRateSDK.git",
        from: "0.9.0"
    )
]
```

**CocoaPods** — add to your `Podfile`, then run `pod install`:

```ruby
pod 'UXRateSDK', '~> 0.9.0'
```

## Step 2 — Initialize the SDK

Add one line to your app entry point. The backend is auto-resolved from the API key prefix (`uxr_…` → production, `uxr_dev_…` → development).

**SwiftUI**

```swift
import SwiftUI
import UXRateSDK

@main
struct MyApp: App {
    init() {
        UXRate.configure(apiKey: "YOUR_API_KEY")
    }

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

**UIKit**

```swift
import UIKit
import UXRateSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UXRate.configure(apiKey: "YOUR_API_KEY")
        return true
    }
}
```

> ⚠️ **Important:** Replace `YOUR_API_KEY` with the key from your UXRate dashboard (Application → API Keys). Use a `uxr_dev_…` key against the development environment while testing.

## Step 3 — Identify users

Tell the SDK who the current user is. Call this after sign-in so interviews are associated with a participant.

```swift
UXRate.identify(
    userId: "user-123",
    properties: [
        "plan": "pro",
        "signup_date": "2025-01-15"
    ]
)
```

> ℹ️ The `userId` is stored as the participant identifier on every interview this user completes. The `properties` dictionary powers `user_segment` trigger rules.

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

```swift
UXRate.track(event: "purchase_complete")
UXRate.track(event: "onboarding_skipped")
UXRate.track(event: "cart_abandoned")
```

## Step 6 — Track screens

**SwiftUI** — add `.surveyScreen("Name")` to the content view inside each `NavigationStack` (SwiftUI cannot auto-detect screen names):

```swift
struct CheckoutView: View {
    var body: some View {
        VStack { /* your checkout UI */ }
            .surveyScreen("Checkout")
    }
}
```

**UIKit** — screen names are auto-detected from the ViewController class name. Override when needed:

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UXRate.setScreen("Checkout")  // overrides "CheckoutViewController"
}
```

## Step 7 — Verify

Run the app with a `uxr_dev_…` key, create a study with a trigger rule in the dashboard, and navigate to the matching screen — the banner should appear. You can also start a test interview from the Studies page.
