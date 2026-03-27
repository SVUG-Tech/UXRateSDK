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

---

### configure

```dart
static Future<void> configure({
  required String apiKey,
  bool autoTrackScreens = false,
  bool useMockService = false,
})
```

**Parameters**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `apiKey` | `String` | *required* | Your UXRate API key. |
| `autoTrackScreens` | `bool` | `false` | Auto-detect screen changes via native swizzle. Usually `false` for Flutter because the app runs in a single native view. |
| `useMockService` | `bool` | `false` | Use the built-in mock backend for testing. |

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
