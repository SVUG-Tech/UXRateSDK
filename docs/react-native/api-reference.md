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
| `setLoggingEnabled(enabled)` | Enable or disable native SDK debug logging. |
| `onBannerWillShow(callback)` | Register a callback before a banner is shown. |
| `hideBanner()` | Programmatically hide the visible banner. |

All methods return `Promise<void>`.

---

### `configure(options: ConfigureOptions): Promise<void>`

```ts
interface ConfigureOptions {
  apiKey: string;
  autoTrackScreens?: boolean;
  mockScreens?: string[];
}
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `apiKey` | `string` | Yes | Your UXRate API key, or `'mock'` for the in-memory mock service. The backend is auto-resolved from the key prefix: `uxr_…` → production, `uxr_dev_…` → development, `uxr_loc_…` → local. |
| `autoTrackScreens` | `boolean` | No | Enable native auto screen tracking. In React Native apps manual `setScreen` calls are preferred. |
| `mockScreens` | `string[]` | No | Screen names for mock survey targeting. Only used when `apiKey` is `'mock'`. |

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

---

### `setLoggingEnabled(enabled: boolean): Promise<void>`

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `enabled` | `boolean` | Yes | `true` to enable debug logging to Logcat (Android) / Xcode console (iOS), `false` to disable. Defaults to `false`. |

Call before `configure()` to capture initialization logs.

---

### `onBannerWillShow(callback: BannerWillShowCallback): void`

```ts
type BannerWillShowCallback = (
  studyId: string,
  screenName: string,
  completion: (shouldShow: boolean) => void
) => void;
```

Register a callback that fires before a survey banner is shown. Call `completion(true)` to allow the banner or `completion(false)` to suppress it. A 2-second safety timeout applies — if completion is never called, the banner shows by default.

---

### `hideBanner(): Promise<void>`

Programmatically hides the currently visible survey banner. Does not track a dismiss event — use for app-driven cleanup rather than user-initiated dismissal.

## TypeScript

Full type definitions are shipped with the package in `index.d.ts`.
