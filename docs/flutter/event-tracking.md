# Event Tracking

## Custom events

Use `UXRate.track` to record any user action. Events are counted locally and
evaluated against trigger rules defined on the UXRate dashboard.

```dart
// Track a single event
await UXRate.track(event: 'add_to_cart');
```

Common event examples:

| Event name          | When to fire                     |
|---------------------|----------------------------------|
| `sign_up`           | User completes registration      |
| `purchase_complete` | User finishes checkout           |
| `feature_used`      | User interacts with a key feature|
| `error_encountered` | An error dialog is shown         |

## Screen tracking

### Manual tracking

Call `setScreen` in each screen's `initState`:

```dart
@override
void initState() {
  super.initState();
  UXRate.setScreen('ProductDetail');
}
```

### NavigatorObserver

For apps using `Navigator`, create an observer to track every route push:

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

// Register it:
MaterialApp(
  navigatorObservers: [UXRateObserver()],
  // ...
);
```

### GoRouter integration

If you use `go_router`, attach the observer via `GoRouter.observers`:

```dart
final router = GoRouter(
  observers: [UXRateObserver()],
  routes: [
    GoRoute(path: '/', name: 'home', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/products', name: 'products', builder: (_, __) => const ProductsScreen()),
  ],
);
```

## Best practices

- Use lowercase, snake_case event names for consistency.
- Keep event names stable across releases so dashboard rules don't break.
- Avoid high-frequency events (e.g., scroll) -- they inflate local storage.
