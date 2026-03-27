# Session Replay

Session replay captures periodic screenshots for visual playback of user sessions. You can watch how users navigate your app from the UXRate dashboard.

## Quality Presets

Replay quality is configured per study in the dashboard. Four presets are available:

| Preset     | Frame Rate | Scale | JPEG Quality |
|------------|-----------|-------|-------------|
| **Low**    | ~1 FPS    | 0.4×  | 25%         |
| **Medium** | ~2 FPS    | 0.5×  | 35%         |
| **High**   | ~3 FPS    | 0.5×  | 45%         |
| **Auto**   | Adaptive  | Adaptive | Adaptive |

**Auto mode** (the default) starts at Medium and adjusts based on upload speed — upgrading to High on fast connections and downgrading to Low on slow ones.

## Capture Scope

- **Off** — Replay is disabled for this study.
- **Sampled** — Only a percentage of participants are recorded, controlled by the sample rate in the dashboard. Sampling is deterministic per participant.
- **All** — Every participant is recorded.

## Trigger Modes

- **Always** — Recording starts immediately when the SDK initializes.
- **Participants** — Same as always, for all sampled participants.
- **Triggered** — Recording starts only when a matching screen or event trigger fires. Useful for capturing specific flows (e.g., checkout) without recording everything.

## Privacy

- Password fields are automatically masked on both platforms.
- Additional masking rules can be configured in the dashboard.
- Replay respects device-level screen recording permissions.

## Platform Notes

- **iOS / Android**: Replay is configured through the native SDK. See the platform API reference for quality preset details.
- **Flutter / React Native**: Replay is handled entirely by the underlying native SDK. No Dart or JS API is needed — enable and configure replay from the dashboard.
