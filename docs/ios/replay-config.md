<!-- iOS SDK v0.2.0 -->

# Session Replay Configuration

Session replay captures periodic screenshots for visual playback of user sessions. Configuration is server-driven via the `replayConfig` field in each study.

## Quality Presets

| Preset     | FPS | Scale | JPEG Quality | Max Buffer Memory |
|------------|-----|-------|-------------|-------------------|
| `low`      | 1   | 0.4x  | 25%         | 5 MB              |
| `medium`   | 2   | 0.5x  | 35%         | 8 MB              |
| `high`     | 3   | 0.5x  | 45%         | 12 MB             |
| `auto`     | 2*  | 0.5x* | 35%*        | 8 MB*             |

*Auto mode starts at medium and adapts based on upload throughput:
- Upload completes in under 5 seconds: upgrades to `high`
- Upload takes 5 to 15 seconds: stays at `medium`
- Upload takes over 15 seconds: downgrades to `low`

Quality re-evaluation happens every 5 flush cycles, so the SDK converges to the best sustainable quality for the user's connection.

## Capture Scope

- **`off`** -- Replay is disabled for this study.
- **`sampled`** -- Only a percentage of participants are recorded. The `sampleRate` field (1-100 in JSON, converted to 0.0-1.0 internally) controls inclusion. Sampling is deterministic per participant ID, so the same device consistently captures or skips across sessions.
- **`all`** -- Every participant is recorded.

## Trigger Modes

- **`always`** -- Capture starts immediately when the SDK configures.
- **`participants`** -- Same as `always`; capture starts on configure for all sampled participants.
- **`triggered`** -- Capture is armed but deferred. Recording begins only when a matching screen or event trigger fires (defined in `triggerScreens`). Stop triggers (`stopTriggers`) halt capture and flush the buffer.

## Buffer and Flushing

Frames are stored in a circular buffer sized by `bufferSeconds` (default 30) multiplied by the current FPS. The buffer flushes every 30 seconds or when memory usage exceeds the profile limit. On flush failure, the SDK retries with exponential backoff and drops the oldest half of the buffer after 5 consecutive failures.
