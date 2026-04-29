# Quick Start

Get UXRate running in your React Native app in four steps.

## 1. Configure the SDK

Call `configure` once at app startup, typically in your root `App.tsx`:

**Quick test with mock surveys (no backend needed):**

```tsx
UXRate.configure({ apiKey: 'mock' });
```

**Production / development / local:**

The SDK auto-resolves the backend from the API key prefix
(`uxr_…` → production, `uxr_dev_…` → dev, `uxr_loc_…` → local):


```tsx
import { UXRate } from 'react-native-uxrate';

useEffect(() => {
  UXRate.configure({ apiKey: 'uxr_your_api_key' });
}, []);
```

## 2. Identify the user

After your user signs in, call `identify` so surveys can be targeted:

```tsx
UXRate.identify({
  userId: 'user-42',
  properties: { plan: 'pro', company: 'Acme' },
});
```

## 3. Track events

Fire custom events that can trigger surveys:

```tsx
UXRate.track({ event: 'checkout_complete' });
```

## 4. Report screen names

React Native runs inside a single native view controller / activity, so
automatic screen tracking will not distinguish between JS routes. Use
`setScreen` on each navigation change:

```tsx
<NavigationContainer
  onStateChange={(state) => {
    const route = state?.routes[state.index];
    if (route) UXRate.setScreen(route.name);
  }}
>
```

That's it -- surveys configured in the UXRate dashboard will now appear to
your users based on events, screens, and segments you define.
