# UXRateSDK

AI-powered in-app survey SDK. Embed conversational surveys into your iOS app with a single line of code.

## Requirements

- iOS 17.0+
- Xcode 16+
- Swift 5.9+

## Installation

### Swift Package Manager

In Xcode: **File → Add Package Dependencies** → paste:

```
https://github.com/SVUG-Tech/UXRateSDK.git
```

Select version **0.1.0** or later.

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SVUG-Tech/UXRateSDK.git", from: "0.1.0")
]
```

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'UXRateSDK', '~> 0.1.0'
```

Then run `pod install`.

### Flutter

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_uxrate: ^0.1.0
```

Then run `flutter pub get` followed by `cd ios && pod install`.

### React Native

```bash
npm install react-native-uxrate
cd ios && pod install
```

For detailed integration instructions (SwiftUI, UIKit, Flutter, React Native, screen tracking, triggers, troubleshooting), see the **[Integration Guide](./INTEGRATION.md)**.

## Quick Start

### SwiftUI

```swift
import SwiftUI
import UXRateSDK

@main
struct MyApp: App {
    init() {
        UXRate.configure(apiKey: "YOUR_API_KEY")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .surveyScreen("Home")   // required — identifies this screen for surveys
        }
    }
}
```

Screen names in pure SwiftUI apps must be set with `.surveyScreen()` — the SDK cannot auto-detect them because iOS type-erases views internally. For UIKit apps, screen names are auto-detected from the view controller class name.

### UIKit

```swift
import UIKit
import UXRateSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UXRate.configure(apiKey: "YOUR_API_KEY")
        return true
    }
}
```

### User Identification & Event Tracking

```swift
// After the user signs in
UXRate.identify(userId: "user-123", properties: ["plan": "pro"])

// Track custom events for trigger rules
UXRate.track(event: "purchase_complete")

// Override auto-detected screen name in UIKit (optional)
UXRate.setScreen("Checkout")
```

### Flutter

```dart
import 'package:flutter_uxrate/flutter_uxrate.dart';

await UXRate.configure(apiKey: 'YOUR_API_KEY');
```

### React Native

```javascript
import { UXRate } from 'react-native-uxrate';

await UXRate.configure({ apiKey: 'YOUR_API_KEY' });
```

## API

| Method / Modifier | Description |
|---|---|
| `configure(apiKey:)` | Initialize the SDK |
| `identify(userId:properties:)` | Set user identity for targeting |
| `track(event:)` | Track custom events |
| `setScreen(_:)` | Manually set the current screen name (UIKit) |
| `.surveyScreen("Name")` | Identify a SwiftUI view for survey targeting |

## Examples

See the [`examples/`](./examples) directory for working demo apps:

- [`examples/ios/`](./examples/ios/) — SwiftUI demo
- [`examples/ios-uikit/`](./examples/ios-uikit/) — UIKit + SwiftUI hybrid demo
- [`examples/flutter/`](./examples/flutter/) — Flutter demo
- [`examples/react-native/`](./examples/react-native/) — React Native demo

## License

Copyright UXRate. All rights reserved.
