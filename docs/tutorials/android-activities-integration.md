<!-- Android SDK v0.2.0 -->

# Activity-Based App Integration

This guide walks through integrating UXRate into an Android app that uses one Activity per screen (no Jetpack Navigation).

## Prerequisites

- UXRate SDK added to your project (see [Installation](../public/installation.md))
- An app with multiple Activity classes representing different screens

## Step 1: Create an Application Class

```kotlin
// MyApp.kt
package com.example.myapp

import android.app.Application
import com.uxrate.sdk.UXRate

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()

        UXRate.configure(
            application = this,
            apiKey = "uxr_your_api_key",
            autoTrackScreens = true  // default, tracks Activity names automatically
        )

        // Optional: enable debug logging during development
        UXRate.loggingEnabled = true
    }
}
```

Register in `AndroidManifest.xml`:

```xml
<application
    android:name=".MyApp"
    ... >
    <activity android:name=".HomeActivity" ... />
    <activity android:name=".ProfileActivity" ... />
    <activity android:name=".SettingsActivity" ... />
</application>
```

## Step 2: Automatic Screen Tracking

With `autoTrackScreens = true` (the default), the SDK registers Activity lifecycle callbacks and derives screen names from class names:

| Activity class       | Tracked screen name |
|---------------------|-------------------|
| `HomeActivity`      | `"Home"`          |
| `ProfileActivity`   | `"Profile"`       |
| `SettingsActivity`  | `"Settings"`      |
| `CheckoutActivity`  | `"Checkout"`      |

The `Activity` and `Fragment` suffixes are stripped automatically.

### Manual Override

If the auto-detected name does not match what you configured in the dashboard, override it:

```kotlin
class ProductDetailActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Override the auto-detected name
        UXRate.setScreen("ProductDetail")

        setContent {
            // Screen content...
        }
    }
}
```

## Step 3: Identify Users

After the user logs in, identify them:

```kotlin
class LoginActivity : ComponentActivity() {

    private fun onLoginSuccess(user: User) {
        UXRate.identify(
            userId = user.id,
            properties = mapOf(
                "tier" to user.subscriptionTier,
                "plan" to user.plan
            )
        )

        startActivity(Intent(this, HomeActivity::class.java))
    }
}
```

## Step 4: Track Custom Events

Track meaningful user actions from any Activity:

```kotlin
class CheckoutActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            Button(onClick = {
                completePurchase()
                UXRate.track(event = "purchase_complete")
            }) {
                Text("Complete Purchase")
            }
        }
    }
}
```

```kotlin
// From anywhere in the app
UXRate.track(
    event = "feature_used",
    properties = mapOf("feature" to "dark_mode")
)
```

## How It Works

1. `UXRate.configure()` registers `Application.ActivityLifecycleCallbacks`.
2. On each `onActivityResumed`, the SDK extracts the screen name from the Activity class and calls `setCurrentScreen()`.
3. The SDK evaluates trigger rules against the current screen, events, and user segment.
4. When a survey matches, a `ComposeView` overlay is attached to the Activity's window to show the banner.
5. Tapping the banner launches `SurveyChatActivity` for the AI-powered survey conversation.
6. On `onActivityStopped`, events are flushed and the replay buffer is uploaded.
7. Frequency caps and cooldowns prevent showing the same survey too often.

## Differences from Compose Integration

| Aspect | Activity-based | Compose with NavHost |
|--------|---------------|---------------------|
| Screen tracking | Automatic from Activity class names | `navController.TrackScreens()` |
| Screen name source | `HomeActivity` becomes `"Home"` | Route `"home"` becomes `"Home"` |
| Manual override | `UXRate.setScreen("Name")` | `SurveyScreen("Name")` or `UXRate.setScreen("Name")` |
| Navigation dependency | None | `androidx.navigation:navigation-compose` |
