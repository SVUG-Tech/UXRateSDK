<!-- iOS SDK v0.2.0 -->

# Quick Start

Get UXRateSDK running in your iOS app in four steps.

## Step 1: Configure the SDK

Call `UXRate.configure` as early as possible in your app lifecycle.

**SwiftUI:**

```swift
import UXRateSDK

@main
struct MyApp: App {
    init() {
        UXRate.configure(apiKey: "uxr_your_api_key")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

**UIKit:**

```swift
import UXRateSDK

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UXRate.configure(apiKey: "uxr_your_api_key")
        return true
    }
}
```

## Step 2: Identify the user

Optionally identify the current user for segment targeting:

```swift
UXRate.identify(userId: "user-123", properties: ["tier": "premium", "plan": "pro"])
```

Call this after login or whenever user context is available. Properties are used by `user_segment` trigger rules.

## Step 3: Track custom events

Track events that your surveys can trigger on:

```swift
UXRate.track(event: "purchase_complete")
UXRate.track(event: "onboarding_finished")
```

Events are batched and sent to the backend automatically.

## Step 4: Mark survey screens

The SDK auto-tracks UIKit view controller names. For **SwiftUI**, add the `.surveyScreen()` modifier to each targetable screen:

```swift
struct CheckoutView: View {
    var body: some View {
        VStack {
            // your content
        }
        .surveyScreen("Checkout")
    }
}
```

The screen name is matched against the `pagePattern` regex in your survey trigger rules. When a match is found, the SDK automatically shows a banner and presents the conversational survey.
