# Event Tracking

## Custom events

Use `UXRate.track` to record events that can trigger surveys:

```tsx
UXRate.track({ event: 'purchase_complete' });
UXRate.track({ event: 'onboarding_finished' });
```

Event names are arbitrary strings. Define matching trigger rules in the UXRate
dashboard to show a survey when a specific event fires.

## Screen tracking

React Native apps run inside a single native ViewController (iOS) or Activity
(Android), so the native auto-track feature sees only one screen. You should
report screens manually using `setScreen`.

### Per-screen tracking with `useFocusEffect`

```tsx
import { useFocusEffect } from '@react-navigation/native';
import { UXRate } from 'react-native-uxrate';

function SettingsScreen() {
  useFocusEffect(() => {
    UXRate.setScreen('Settings');
  });

  return <View>...</View>;
}
```

### Global tracking with React Navigation

You can report every navigation change from a single place:

```tsx
import { NavigationContainer } from '@react-navigation/native';

<NavigationContainer
  onStateChange={(state) => {
    const route = state?.routes[state.index];
    if (route) UXRate.setScreen(route.name);
  }}
>
  {/* screens */}
</NavigationContainer>
```

See the [React Navigation integration tutorial](../tutorials/react-navigation-integration.md) for a full walkthrough.

## Best practices

- Keep event names short and consistent (e.g. `snake_case`).
- Report screens as early as possible so survey targeting is accurate.
- Avoid tracking high-frequency events (e.g. scroll positions) -- they add
  noise without improving targeting.
