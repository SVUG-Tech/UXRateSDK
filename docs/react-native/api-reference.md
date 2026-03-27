# API Reference

All methods are available on the `UXRate` export:

```tsx
import { UXRate } from 'react-native-uxrate';
```

## Methods

| Method | Description |
|--------|-------------|
| `configure(options)` | Initialise the SDK. Call once at app startup. |
| `identify(options)` | Identify the current user for survey targeting. |
| `track(options)` | Record a custom event. |
| `setScreen(name)` | Report the current screen name. |

All methods return `Promise<void>`.

---

### `configure(options: ConfigureOptions): Promise<void>`

```ts
interface ConfigureOptions {
  apiKey: string;
  autoTrackScreens?: boolean; // default: false
  useMockService?: boolean;   // default: false
}
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `apiKey` | `string` | Yes | Your UXRate API key. |
| `autoTrackScreens` | `boolean` | No | Enable native auto screen tracking. In React Native apps manual `setScreen` calls are preferred. |
| `useMockService` | `boolean` | No | Use the built-in mock backend for local testing. |

---

### `identify(options: IdentifyOptions): Promise<void>`

```ts
interface IdentifyOptions {
  userId: string;
  properties?: Record<string, string>;
}
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `userId` | `string` | Yes | A stable user identifier. |
| `properties` | `Record<string, string>` | No | Key-value properties for segment targeting. |

---

### `track(options: TrackOptions): Promise<void>`

```ts
interface TrackOptions {
  event: string;
}
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event` | `string` | Yes | The event name to record. |

---

### `setScreen(name: string): Promise<void>`

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | `string` | Yes | The screen name to report. |

## TypeScript

Full type definitions are shipped with the package in `index.d.ts`.
