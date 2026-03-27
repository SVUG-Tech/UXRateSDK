# React Navigation Integration

This tutorial walks through integrating UXRate screen tracking with React
Navigation in a React Native app.

## Prerequisites

- `react-native-uxrate` installed and linked (see [Installation](../public/installation.md))
- `@react-navigation/native` and a navigator (e.g. `@react-navigation/native-stack`) installed

## Step 1 -- Configure UXRate

In your root component, initialise the SDK:

```tsx
import React, { useEffect } from 'react';
import { UXRate } from 'react-native-uxrate';

function App() {
  useEffect(() => {
    UXRate.configure({ apiKey: 'YOUR_API_KEY' });
  }, []);

  return (
    // ...
  );
}
```

## Step 2 -- Add global screen tracking

Use the `onStateChange` callback on `NavigationContainer` to report every
route change:

```tsx
import { NavigationContainer } from '@react-navigation/native';

function App() {
  // ... configure (Step 1)

  return (
    <NavigationContainer
      onStateChange={(state) => {
        const route = state?.routes[state.index];
        if (route) {
          UXRate.setScreen(route.name);
        }
      }}
    >
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Profile" component={ProfileScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

This reports the top-level route name on every navigation event.

## Step 3 -- Track the initial screen

`onStateChange` does not fire for the initial route. To capture it, use a
navigation ref:

```tsx
import { useRef } from 'react';
import { NavigationContainer, useNavigationContainerRef } from '@react-navigation/native';

function App() {
  const navigationRef = useNavigationContainerRef();

  return (
    <NavigationContainer
      ref={navigationRef}
      onReady={() => {
        const route = navigationRef.getCurrentRoute();
        if (route) UXRate.setScreen(route.name);
      }}
      onStateChange={(state) => {
        const route = state?.routes[state.index];
        if (route) UXRate.setScreen(route.name);
      }}
    >
      {/* screens */}
    </NavigationContainer>
  );
}
```

## Step 4 -- Fire custom events

Add event tracking to buttons or other interactions:

```tsx
import { Button } from 'react-native';
import { UXRate } from 'react-native-uxrate';

function HomeScreen() {
  return (
    <Button
      title="Complete Onboarding"
      onPress={() => UXRate.track({ event: 'onboarding_complete' })}
    />
  );
}
```

## Step 5 -- Per-screen tracking (optional)

If you need per-screen side effects (analytics, etc.) you can also use
`useFocusEffect`:

```tsx
import { useFocusEffect } from '@react-navigation/native';
import { UXRate } from 'react-native-uxrate';

function ProfileScreen() {
  useFocusEffect(() => {
    UXRate.setScreen('Profile');
  });

  return (/* ... */);
}
```

## Summary

- Use `onStateChange` + `onReady` on `NavigationContainer` for global
  screen tracking.
- Use `UXRate.track` to fire custom events from any component.
- Optionally use `useFocusEffect` for per-screen logic.
