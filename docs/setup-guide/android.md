# Android

## Requirements

`Android 7.0+ (API 24)` · `Kotlin 1.9+` · `Jetpack Compose or Views`

## Step 1 — Install the SDK

Add the UXRate Maven repository and dependency to your Gradle config:

```kotlin
// settings.gradle.kts
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven("https://svug-tech.github.io/UXRateSDK")
    }
}
```

```kotlin
// app/build.gradle.kts
dependencies {
    implementation("com.uxrate:uxrate-sdk:0.9.0")
}
```

## Step 2 — Initialize the SDK

Call `configure()` once in `Application.onCreate()`. The backend is auto-resolved from the API key prefix (`uxr_…` → production, `uxr_dev_…` → development).

```kotlin
import android.app.Application
import com.uxrate.sdk.UXRate

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        UXRate.configure(
            application = this,
            apiKey = "YOUR_API_KEY"
        )
    }
}
```

> ⚠️ **Important:** Replace `YOUR_API_KEY` with the key from your UXRate dashboard (Application → API Keys). Use a `uxr_dev_…` key against the development environment while testing.

## Step 3 — Identify users

```kotlin
UXRate.identify(
    userId = "user-123",
    properties = mapOf(
        "plan" to "pro",
        "signup_date" to "2025-01-15"
    )
)
```

> ℹ️ The `userId` is stored as the participant identifier on every interview this user completes. The `properties` map powers `user_segment` trigger rules.

## Step 4 — Trigger rules

Interviews fire automatically when the SDK detects a matching rule configured in the dashboard:

| Rule | Fires when |
|------|------------|
| `page_visit` | A user visits a screen matching a name pattern (Step 6 tracking) |
| `event` | A specific event fires N times (Step 5 tracking) |
| `time_based` | N days have passed since app install |
| `user_segment` | The user has a specific `identify()` property value |

When multiple studies match the same screen, the **highest-priority** study (set in the panel) is shown; ties go to the newest study.

## Step 5 — Track events

```kotlin
UXRate.track(event = "purchase_complete")
UXRate.track(event = "onboarding_skipped")
UXRate.track(event = "cart_abandoned")
```

## Step 6 — Track screens

Activity names are auto-tracked. Single-Activity apps (Navigation Compose) should report screens explicitly:

```kotlin
@Composable
fun CheckoutScreen() {
    LaunchedEffect(Unit) {
        UXRate.setScreen("Checkout")
    }
    // your checkout UI
}
```

## Step 7 — Verify

Run the app with a `uxr_dev_…` key, create a study with a trigger rule in the dashboard, and navigate to the matching screen — the banner should appear. You can also start a test interview from the Studies page.
