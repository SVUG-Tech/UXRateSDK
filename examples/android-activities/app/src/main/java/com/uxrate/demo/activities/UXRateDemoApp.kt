package com.uxrate.demo.activities

import android.app.Application
import com.uxrate.sdk.UXRate
import com.uxrate.sdk.models.SDKTheme

/**
 * Application class — configures the UXRate SDK.
 *
 * In a multi-Activity app, auto screen tracking works out of the box.
 * Each Activity's class name is automatically reported as the screen name
 * (e.g., HomeActivity → "Home", ProfileActivity → "Profile").
 */
class UXRateDemoApp : Application() {
    override fun onCreate() {
        super.onCreate()
        UXRate.configure(
            application = this,
            apiKey = "YOUR_API_KEY",
            autoTrackScreens = true,  // auto-detects Activity names
            theme = SDKTheme.AUTO,
        )
        UXRate.loggingEnabled = true
        UXRate.identify(userId = "activities-demo-user", properties = mapOf("platform" to "android", "pattern" to "activities"))
    }
}
