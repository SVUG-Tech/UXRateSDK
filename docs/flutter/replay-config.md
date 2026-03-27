# Session Replay Configuration

## Overview

Session replay captures user interactions so you can watch how users navigate
your app. In the Flutter plugin, replay is handled entirely by the **native
iOS and Android UXRate SDKs** -- there is no Dart-level API for replay.

## How it works

1. The native SDK records touches, gestures, and screen transitions.
2. Recordings are uploaded to the UXRate backend.
3. You view replays in the UXRate dashboard.

## Configuration

All replay settings are managed from the **UXRate dashboard**:

- **Enable / disable** replay per project.
- **Sampling rate** -- control what percentage of sessions are recorded.
- **Masking rules** -- mark sensitive fields so their content is hidden in
  recordings.
- **Max session length** -- cap the duration of a single recording.

No code changes are required in your Flutter app to configure replay. If
you need to adjust settings, log in to the dashboard at
<https://app-dev.uxrate.com>.

## Privacy

- Text fields marked as `secureTextEntry` (iOS) or `inputType="textPassword"`
  (Android) are automatically masked.
- Additional masking can be configured in the dashboard.
- Replay respects the user's device-level screen recording permissions.
