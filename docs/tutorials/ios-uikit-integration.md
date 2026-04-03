<!-- iOS SDK v0.3.0 -->

# UIKit Integration Tutorial

This tutorial walks through integrating UXRateSDK into a UIKit app from scratch.

## Prerequisites

- Xcode 15+
- iOS 17.0+ deployment target
- UXRateSDK installed via SPM, CocoaPods, or XCFramework (see [Installation](../public/installation.md))

## Step 1: Configure the SDK in AppDelegate

Initialize the SDK in `application(_:didFinishLaunchingWithOptions:)`:

```swift
import UIKit
import UXRateSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UXRate.configure(apiKey: "uxr_your_api_key")
        return true
    }
}
```

The SDK automatically:
- Swizzles `UIViewController.viewDidAppear` to detect screen names
- Attaches a floating banner overlay window
- Manages chat sheet presentation

## Step 2: Screen tracking

**Automatic tracking** is enabled by default. The SDK detects screen names from UIViewController class names (e.g. `CheckoutViewController`).

To override the auto-detected name with a cleaner identifier, call `UXRate.setScreen()` in `viewDidAppear`:

```swift
class CheckoutViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.setScreen("Checkout")
    }
}
```

This replaces the auto-detected `"CheckoutViewController"` with `"Checkout"` for trigger matching. The SDK prevents double-counting when both auto and manual tracking fire.

### Skipped view controllers

The swizzle automatically skips system and internal view controllers with these prefixes: `UI`, `UXRate`, `_`, `SwiftUI`, `PresentationHosting`, `NavigationStack`, `TabHosting`, `Gesture`, `Input`.

## Step 3: Track custom events

Track events from button actions, table view selections, or any user interaction:

```swift
class ProductViewController: UIViewController {

    @IBAction func addToCartTapped(_ sender: UIButton) {
        addItemToCart()
        UXRate.track(event: "item_added_to_cart")
    }

    @IBAction func purchaseTapped(_ sender: UIButton) {
        completePurchase()
        UXRate.track(event: "purchase_complete")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.setScreen("Product")
    }
}
```

Events are batched in memory and flushed to the backend automatically (on threshold or app backgrounding).

## Step 4: Identify users (optional)

After login, identify the user for segment targeting:

```swift
class LoginViewController: UIViewController {

    func didCompleteLogin(user: User) {
        UXRate.identify(userId: user.id, properties: [
            "tier": user.tier,
            "company": user.companyName
        ])
    }
}
```

Properties are merged with any previously set values and used by `user_segment` trigger rules.

## Step 5: UITabBarController example

For a tab-based app, add screen tracking in each tab's view controller:

```swift
class HomeViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.setScreen("Home")
    }
}

class ProfileViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.setScreen("Profile")
    }
}

class SettingsViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.setScreen("Settings")
    }
}
```

## Step 6: Configure options (optional)

Customize SDK behavior:

```swift
UXRate.configure(
    apiKey: "uxr_your_api_key",
    autoTrackScreens: true,         // set false to disable swizzling
    overlapStrategy: .showFirst,    // .showFirst, .showLast, .showRandom, .showNone
    theme: .auto                    // .auto, .light, .dark
)
```

Disable auto-tracking if you prefer fully manual screen tracking:

```swift
UXRate.configure(apiKey: "uxr_your_api_key", autoTrackScreens: false)
// Then call UXRate.setScreen("ScreenName") in every viewDidAppear
```

## Testing with mock data

Use the mock service for development:

```swift
#if DEBUG
UXRate.configure(apiKey: "uxr_test", useMockService: true)
#else
UXRate.configure(apiKey: "uxr_your_api_key")
#endif
```

The mock service returns sample survey configurations and simulates the conversational interview flow without network calls.
