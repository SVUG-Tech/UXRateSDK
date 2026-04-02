<!-- iOS SDK v0.2.2 -->

# Installation

UXRateSDK requires **iOS 17.0+** and **Swift 5.9+**. The SDK has zero external dependencies.

## Swift Package Manager (recommended)

1. In Xcode, go to **File > Add Package Dependencies...**
2. Enter the repository URL:
   ```
   https://github.com/SVUG-Tech/UXRateSDK.git
   ```
3. Select a version rule (e.g. **Up to Next Major Version**) and click **Add Package**.
4. Select the `UXRateSDK` library and add it to your app target.

Alternatively, add it directly in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SVUG-Tech/UXRateSDK.git", from: "0.1.0")
]
```

Then add `"UXRateSDK"` to your target's dependencies.

## CocoaPods

Add UXRateSDK to your `Podfile`:

```ruby
pod 'UXRateSDK'
```

Then run:

```bash
pod install
```

## Manual (XCFramework)

1. Download the latest `UXRateSDK.xcframework.zip` from the [Releases page](https://github.com/SVUG-Tech/UXRateSDK/releases).
2. Unzip and drag `UXRateSDK.xcframework` into your Xcode project.
3. In your target's **General > Frameworks, Libraries, and Embedded Content**, ensure UXRateSDK is set to **Embed & Sign**.
