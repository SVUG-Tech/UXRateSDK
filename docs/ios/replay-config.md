<!-- iOS SDK v0.8.0 -->

# Session Replay — iOS

> For concepts, quality presets, and capture modes, see [Session Replay](Session-Replay).

## iOS Quality Presets

| Preset     | FPS | Scale | JPEG Quality | Max Buffer Memory |
|------------|-----|-------|-------------|-------------------|
| `low`      | 1   | 0.4x  | 25%         | 5 MB              |
| `medium`   | 2   | 0.5x  | 35%         | 8 MB              |
| `high`     | 3   | 0.5x  | 45%         | 12 MB             |
| `auto`     | 2*  | 0.5x* | 35%*        | 8 MB*             |

\*Auto mode starts at medium and adapts based on upload throughput.

## Configuration

Replay is server-driven via the `replayConfig` field in each study. No client-side code is needed — manage all settings from the UXRate dashboard.
