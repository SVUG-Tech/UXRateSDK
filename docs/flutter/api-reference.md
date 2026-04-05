# API Reference

All methods are static and live on the `UXRate` class. Import with:

```dart
import 'package:flutter_uxrate/flutter_uxrate.dart';
```

## Methods

| Method | Description |
|--------|-------------|
| [`configure`](#configure) | Initialise the SDK. Must be called before any other method. |
| [`identify`](#identify) | Associate the current session with a user. |
| [`track`](#track) | Record a custom event. |
| [`setScreen`](#setscreen) | Report the current screen name. |
| [`setLoggingEnabled`](#setloggingenabled) | Enable or disable native SDK debug logging. |

---

### configure

```dart
static Future<void> configure({
  required String apiKey,
  String environment = 'production',
  bool autoTrackScreens = false,
  List<String>? mockScreens,
})
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `apiKey` | `String` | *required* | Your UXRate API key. |
| `environment` | `String` | `'production'` | Backend environment: `'production'`, `'development'`, `'local'`, or `'mock'`. |
| `autoTrackScreens` | `bool` | `false` | Auto-detect screen changes via native swizzle. Usually `false` for Flutter because the app runs in a single native view. |
| `mockScreens` | `List<String>?` | `null` | Screen names for mock survey targeting. Only used when environment is `'mock'`. |

---

### identify

```dart
static Future<void> identify({
  required String userId,
  Map<String, String> properties = const {},
})
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `userId` | `String` | *required* | Stable identifier for the user. |
| `properties` | `Map<String, String>` | `{}` | Key-value pairs for segment targeting (e.g. `{'plan': 'pro'}`). |

---

### track

```dart
static Future<void> track({required String event})
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `event` | `String` | *required* | Name of the event to record. |

---

### setScreen

```dart
static Future<void> setScreen(String name)
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `name` | `String` | *required* | Name of the current screen. |

---

### setLoggingEnabled

```dart
static Future<void> setLoggingEnabled(bool enabled)
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `enabled` | `bool` | *required* | `true` to enable debug logging to Logcat (Android) / Xcode console (iOS), `false` to disable. Defaults to `false`. |

Call before `configure()` to capture initialization logs.
