# Session Replay Configuration

## Overview

Session replay is handled entirely by the native UXRate SDKs (iOS and Android).
The React Native module does not expose separate replay APIs -- replay capture
is started automatically by the native SDK when it is enabled for your project.

## Enabling replay

1. Open the UXRate dashboard.
2. Navigate to your project settings.
3. Toggle **Session Replay** on.
4. Configure the desired sampling rate and privacy masking options.

Once enabled on the dashboard the native SDKs begin capturing replay data
without any additional code changes in your React Native app.

## Privacy masking

Sensitive views can be masked from replays. Masking rules are configured in
the UXRate dashboard and applied at the native layer. Because React Native
renders through native view hierarchies, the standard masking rules apply
to RN-rendered content as well.

## Troubleshooting

- **Replay not appearing**: Make sure the native SDK versions match the
  minimum required for replay support (check the native SDK changelogs).
- **Missing frames**: Replay capture runs at a reduced frame rate to minimise
  performance impact. Short interactions may not produce visible frames.
- **Large payload warnings**: If your app has complex view hierarchies,
  consider increasing the masking scope to reduce payload size.
