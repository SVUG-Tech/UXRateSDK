# Session Replay — React Native

> For concepts, quality presets, and capture modes, see [Session Replay](Session-Replay).

Replay is handled entirely by the native UXRate SDKs (iOS and Android). The React Native module does not expose separate replay APIs.

## Enabling Replay

1. Open the UXRate dashboard.
2. Navigate to your project settings.
3. Toggle **Session Replay** on.
4. Configure sampling rate and privacy masking.

No additional code changes are needed in your React Native app.

## Troubleshooting

- **Replay not appearing**: Check native SDK versions match minimum required for replay support.
- **Missing frames**: Replay runs at a reduced frame rate — short interactions may not produce visible frames.
