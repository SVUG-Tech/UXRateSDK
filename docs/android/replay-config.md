<!-- Android SDK v0.6.0 -->

# Session Replay — Android

> For concepts, quality presets, and capture modes, see [Session Replay](Session-Replay).

## Android Quality Presets

| Preset   | Frame Interval | Scale | JPEG Quality | Buffer Memory | Max Frames |
|----------|---------------|-------|-------------|---------------|------------|
| `low`    | 1000 ms       | 0.4x  | 25          | 5 MB          | 1800       |
| `medium` | 500 ms        | 0.5x  | 35          | 8 MB          | 3600       |
| `high`   | 333 ms        | 0.5x  | 45          | 12 MB         | 5400       |
| `auto`   | starts medium | adaptive | adaptive | adaptive    | adaptive   |

Auto mode starts at medium and adapts based on upload performance.

## Stop Triggers

Configure `stopTriggers` in the dashboard to automatically stop recording when a specific screen is visited or event fires. Useful for ending capture after a checkout flow or sensitive screen.
