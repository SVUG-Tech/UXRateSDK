<!-- Android SDK v0.8.0 -->

# Quick Start

Get UXRate running in four steps.

## Step 1: Configure in Application.onCreate()

Create (or update) your `Application` subclass and register it in `AndroidManifest.xml`:

```xml
<application android:name=".MyApp" ... >
```

**Quick test with mock surveys (no backend needed):**

```kotlin
UXRate.configure(application = this, apiKey = "mock")
```

**Production / development / local:**

The SDK auto-resolves the backend from the API key prefix
(`uxr_…` → production, `uxr_dev_…` → dev, `uxr_loc_…` → local):


```kotlin
import android.app.Application
import com.uxrate.sdk.UXRate

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        UXRate.configure(
            application = this,
            apiKey = "uxr_your_api_key"
        )
    }
}
```

## Step 2: Identify the User

Call `identify` once the user is known (e.g., after login):

```kotlin
UXRate.identify(
    userId = "user-123",
    properties = mapOf("tier" to "premium", "plan" to "pro")
)
```

Properties are used for user-segment trigger rules configured in the dashboard.

## Step 3: Track Events

Track custom events to trigger surveys based on user actions:

```kotlin
UXRate.track(event = "purchase_complete")
UXRate.track(event = "feature_used", properties = mapOf("feature" to "export"))
```

## Step 4: Screen Tracking

**Automatic (Activity-based):** Screen names are derived from Activity class names by default (e.g., `HomeActivity` becomes `"Home"`). No code needed.

**Manual override:** Set the screen name explicitly when auto-detection is not sufficient:

```kotlin
UXRate.setScreen(name = "Checkout")
```

**Jetpack Compose with NavHost:** Use `TrackScreens()` on your `NavController` to auto-track route changes:

```kotlin
import com.uxrate.sdk.ui.TrackScreens

val navController = rememberNavController()
navController.TrackScreens()

NavHost(navController, startDestination = "home") {
    composable("home") { HomeScreen() }
    composable("profile") { ProfileScreen() }
}
```

**Per-screen Composable:** Wrap individual screens with `SurveyScreen()`:

```kotlin
import com.uxrate.sdk.ui.SurveyScreen

@Composable
fun HomeScreen() {
    SurveyScreen("Home")
}
```
