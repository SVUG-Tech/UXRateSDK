<!-- Android SDK v0.2.1 -->

# Session Replay Configuration

## Quality Presets

| Preset   | Frame interval | Scale | JPEG quality | Buffer memory | Max frames |
|----------|---------------|-------|-------------|---------------|------------|
| `low`    | 1000 ms       | 0.4x  | 25          | 5 MB          | 1800       |
| `medium` | 500 ms        | 0.5x  | 35          | 8 MB          | 3600       |
| `high`   | 333 ms        | 0.5x  | 45          | 12 MB         | 5400       |
| `auto`   | starts medium | adaptive | adaptive | adaptive    | adaptive   |

## Auto Mode

When quality is set to `"auto"` (the default), the SDK starts at MEDIUM and adapts based on upload performance. Every 5 flush cycles the SDK measures the average upload duration:

- Average < 5 seconds: upgrades to HIGH
- Average 5-15 seconds: stays at MEDIUM
- Average > 15 seconds: downgrades to LOW

This keeps replay quality as high as possible without degrading the user's network experience.

## Scope

- `"off"` -- Replay capture is disabled.
- `"sampled"` -- Only a percentage of participants are recorded, controlled by `sampleRate` (0-100 on the dashboard, converted to 0.0-1.0 internally). Sampling is deterministic per participant ID.
- `"all"` -- Every participant is recorded.

## Trigger Modes

- `"always"` -- Capture starts immediately on app launch.
- `"participants"` -- Capture starts for sampled or all participants after configuration.
- `"triggered"` -- Capture is armed but deferred. Recording begins only when a matching screen or event trigger fires. Trigger screens and events are configured via `triggerScreens` in the dashboard.

## Stop Triggers

Configure `stopTriggers` to automatically stop recording when a specific screen is visited or event fires. Useful for ending capture after a checkout flow or sensitive screen.

## Buffer and Flush

Frames are buffered in memory and flushed to the server every 30 seconds, on app background, and when buffer memory exceeds the quality profile limit. On upload failure the SDK retries with exponential backoff and drops the oldest half of frames after 5 consecutive failures.
