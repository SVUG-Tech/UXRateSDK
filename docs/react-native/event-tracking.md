# Event Tracking — React Native

> For concepts and best practices, see [Event Tracking](Event-Tracking).

## Custom Events

```tsx
UXRate.track({ event: 'purchase_complete' });
UXRate.track({ event: 'onboarding_finished' });
```

## Screen Tracking

React Native runs inside a single native view, so auto-track sees only one screen. Report screens manually.

### Per-screen with `useFocusEffect`

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

### Global with React Navigation

```tsx
<NavigationContainer
  onStateChange={(state) => {
    const route = state?.routes[state.index];
    if (route) UXRate.setScreen(route.name);
  }}
>
  {/* screens */}
</NavigationContainer>
```
