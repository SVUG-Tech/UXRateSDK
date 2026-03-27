# Tutorial: Integrating UXRate into a Flutter App

This guide walks through adding the UXRate Flutter SDK to a new project from
scratch.

## Prerequisites

- Flutter 3.10+ installed (`flutter --version`)
- An API key from the UXRate dashboard

## Step 1 -- Create a new Flutter project

```bash
flutter create my_app
cd my_app
```

## Step 2 -- Add the dependency

Open `pubspec.yaml` and add `flutter_uxrate`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_uxrate:
    git:
      url: https://github.com/SVUG-Tech/flutter-uxrate.git
      ref: 0.1.0
```

Install:

```bash
flutter pub get
```

For iOS, also run:

```bash
cd ios && pod install && cd ..
```

For Android, add the Maven repo to `android/build.gradle`:

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://svug-tech.github.io/UXRateSDK' }
    }
}
```

## Step 3 -- Configure the SDK

Edit `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_uxrate/flutter_uxrate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UXRate.configure(apiKey: 'YOUR_API_KEY');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}
```

## Step 4 -- Add screen tracking

Report the screen name when a widget mounts:

```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    UXRate.setScreen('Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Welcome!')),
    );
  }
}
```

## Step 5 -- Identify the user

After sign-in, call `identify` so surveys can target specific segments:

```dart
await UXRate.identify(
  userId: 'user-42',
  properties: {'plan': 'pro'},
);
```

## Step 6 -- Track events

Fire events on meaningful user actions:

```dart
ElevatedButton(
  onPressed: () {
    UXRate.track(event: 'checkout_started');
  },
  child: const Text('Checkout'),
)
```

## Step 7 -- Navigate between screens

When pushing a new route, report the screen:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    settings: const RouteSettings(name: 'Products'),
    builder: (_) {
      UXRate.setScreen('Products');
      return const ProductsScreen();
    },
  ),
);
```

## Step 8 -- Run the app

```bash
flutter run
```

Open the UXRate dashboard to verify events and screen views are arriving.

## Next steps

- Configure surveys and trigger rules on the UXRate dashboard.
- See [Event Tracking](../public/event-tracking.md) for NavigatorObserver and
  GoRouter patterns.
- See [API Reference](../public/api-reference.md) for full method signatures.
