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

## Quick Start

### Swift / SwiftUI

```swift
import UXRateSDK

@main
struct MyApp: App {
    init() {
        UXRate.configure(
            apiKey: "YOUR_API_KEY",
            baseURL: URL(string: "https://api.uxrate.app")!,
            autoTrackScreens: true
        )
    }

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
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

| Method | Description |
|--------|-------------|
| `configure(apiKey:baseURL:autoTrackScreens:)` | Initialize the SDK |
| `identify(userId:properties:)` | Set user identity for targeting |
| `track(event:)` | Track custom events |
| `setScreen(name:)` | Manually set the current screen name |

## Examples

See the [`examples/`](./examples) directory for working demo apps:

- [`examples/ios/`](./examples/ios/) — Swift/SwiftUI demo
- [`examples/flutter/`](./examples/flutter/) — Flutter demo
- [`examples/react-native/`](./examples/react-native/) — React Native demo

## License

Copyright UXRate. All rights reserved.
