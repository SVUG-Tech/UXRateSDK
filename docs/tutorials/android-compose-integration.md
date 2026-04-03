<!-- Android SDK v0.3.0 -->

# Jetpack Compose Integration

This guide walks through integrating UXRate into a Jetpack Compose app with Navigation.

## Prerequisites

- UXRate SDK added to your project (see [Installation](../public/installation.md))
- A Compose app using `androidx.navigation:navigation-compose`

## Step 1: Create an Application Class

If you do not already have one, create a custom `Application` class:

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
            apiKey = "uxr_your_api_key"
        )

        // Optional: enable debug logging during development
        UXRate.loggingEnabled = true
    }
}
```

Register it in `AndroidManifest.xml`:

```xml
<application
    android:name=".MyApp"
    ... >
```

## Step 2: Track Screens via NavHost

In the composable where you set up navigation, call `TrackScreens()` on your `NavController`. This automatically reports every route change to UXRate:

```kotlin
// MainNavigation.kt
package com.example.myapp

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.uxrate.sdk.ui.TrackScreens

@Composable
fun MainNavigation() {
    val navController = rememberNavController()

    // One line -- auto-tracks all routes
    navController.TrackScreens()

    NavHost(navController, startDestination = "home") {
        composable("home") { HomeScreen(navController) }
        composable("profile") { ProfileScreen(navController) }
        composable("settings") { SettingsScreen(navController) }
    }
}
```

By default, route names are capitalized (e.g., `"home"` becomes `"Home"`). Provide a mapper for custom names:

```kotlin
navController.TrackScreens { route ->
    when (route) {
        "home" -> "Dashboard"
        "profile/{userId}" -> "UserProfile"
        else -> route.replaceFirstChar { it.uppercase() }
    }
}
```

### Alternative: Per-Screen Tracking with LaunchedEffect

If you are not using `TrackScreens()`, you can set the screen name manually inside each composable:

```kotlin
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import com.uxrate.sdk.UXRate

@Composable
fun CheckoutScreen() {
    LaunchedEffect(Unit) {
        UXRate.setScreen("Checkout")
    }

    // Screen content...
}
```

Or use the `SurveyScreen` composable which handles both set and clear:

```kotlin
import com.uxrate.sdk.ui.SurveyScreen

@Composable
fun CheckoutScreen() {
    SurveyScreen("Checkout")
    // Screen content...
}
```

## Step 3: Identify Users

After the user logs in, identify them so segment-based trigger rules work:

```kotlin
// In your login success handler
UXRate.identify(
    userId = user.id,
    properties = mapOf(
        "tier" to user.subscriptionTier,
        "plan" to user.plan
    )
)
```

## Step 4: Track Custom Events

Track meaningful user actions that can trigger surveys:

```kotlin
@Composable
fun ProductScreen(product: Product) {
    Button(onClick = {
        // Business logic...
        addToCart(product)

        // Track the event
        UXRate.track(
            event = "add_to_cart",
            properties = mapOf("productId" to product.id)
        )
    }) {
        Text("Add to Cart")
    }
}
```

```kotlin
// After a purchase completes
UXRate.track(event = "purchase_complete")
```

## How It Works

1. `UXRate.configure()` fetches survey config from the backend and registers Activity lifecycle callbacks.
2. `TrackScreens()` observes the NavController back stack and calls `UXRate.setScreen()` on each route change.
3. The SDK evaluates trigger rules (screen, events, time, user segment) against the current context.
4. When a survey matches, a Compose overlay banner appears at the top or bottom of the screen.
5. Tapping the banner opens a fullscreen AI-powered survey chat.
6. Frequency caps (per-user, per-session, cooldown) prevent survey fatigue.
