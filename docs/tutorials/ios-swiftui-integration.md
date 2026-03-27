<!-- iOS SDK v0.2.1 -->

# SwiftUI Integration Tutorial

This tutorial walks through integrating UXRateSDK into a SwiftUI app from scratch.

## Prerequisites

- Xcode 15+
- iOS 17.0+ deployment target
- UXRateSDK installed via SPM, CocoaPods, or XCFramework (see [Installation](../public/installation.md))

## Step 1: Configure the SDK at launch

Initialize the SDK in your `App` struct's `init()`:

```swift
import SwiftUI
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

The SDK attaches its own overlay window automatically. No additional setup is needed for the banner and chat UI to appear.

## Step 2: Mark screens with .surveyScreen()

SwiftUI uses type-erased views inside `NavigationStack` and `TabView`, so the SDK cannot auto-detect screen names. Add `.surveyScreen()` to each view you want to target with surveys:

```swift
struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                // your content
            }
            .navigationTitle("Home")
        }
        .surveyScreen("Home")
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // profile content
            }
            .navigationTitle("Profile")
        }
        .surveyScreen("Profile")
    }
}
```

Place `.surveyScreen()` on the outermost view of each tab or navigation destination. The modifier tracks the screen once when the view first appears.

## Step 3: Track custom events

Track events on user interactions like button taps:

```swift
struct CheckoutView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Order Summary")
                .font(.title)

            Button("Complete Purchase") {
                completePurchase()
                UXRate.track(event: "purchase_complete")
            }
            .buttonStyle(.borderedProminent)

            Button("Add to Wishlist") {
                UXRate.track(event: "wishlist_add")
            }
        }
        .surveyScreen("Checkout")
    }

    private func completePurchase() {
        // your purchase logic
    }
}
```

Events are batched and sent to the backend automatically. The SDK flushes the event queue when the batch threshold is reached or when the app enters the background.

## Step 4: Identify users (optional)

After login, identify the user for segment-targeted surveys:

```swift
struct LoginView: View {
    @State private var email = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
            Button("Sign In") {
                signIn(email: email)
            }
        }
        .surveyScreen("Login")
    }

    private func signIn(email: String) {
        // your authentication logic
        let user = AuthService.shared.currentUser
        UXRate.identify(userId: user.id, properties: [
            "tier": user.subscriptionTier,
            "plan": user.plan
        ])
    }
}
```

## Step 5: Configure options (optional)

Customize SDK behavior in the `configure` call:

```swift
UXRate.configure(
    apiKey: "uxr_your_api_key",
    autoTrackScreens: true,         // auto-detect UIKit screen names
    overlapStrategy: .showFirst,    // how to handle multiple matching surveys
    theme: .auto                    // .auto, .light, or .dark
)
```

To silence SDK debug logs in development:

```swift
UXRate.loggingEnabled = false
UXRate.configure(apiKey: "uxr_your_api_key")
```

## Testing with mock data

Use `useMockService: true` during development to test the survey flow without a real backend:

```swift
#if DEBUG
UXRate.configure(apiKey: "uxr_test", useMockService: true)
#else
UXRate.configure(apiKey: "uxr_your_api_key")
#endif
```
