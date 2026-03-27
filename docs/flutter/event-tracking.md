# Event Tracking — Flutter

> For concepts and best practices, see [Event Tracking](Event-Tracking).

## Custom Events

```dart
await UXRate.track(event: 'add_to_cart');
```

## Screen Tracking

### Manual

```dart
@override
void initState() {
  super.initState();
  UXRate.setScreen('ProductDetail');
}
```

### NavigatorObserver

```dart
class UXRateObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    final name = route.settings.name;
    if (name != null) {
      UXRate.setScreen(name);
    }
  }
}

MaterialApp(
  navigatorObservers: [UXRateObserver()],
);
```

### GoRouter

```dart
final router = GoRouter(
  observers: [UXRateObserver()],
  routes: [
    GoRoute(path: '/', name: 'home', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/products', name: 'products', builder: (_, __) => const ProductsScreen()),
  ],
);
```
