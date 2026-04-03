package com.uxrate.demo.activities

import android.app.Application
import com.uxrate.sdk.UXRate
import com.uxrate.sdk.models.Environment
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
        // Mock environment — works immediately without dashboard setup.
        UXRate.configure(
            application = this,
            apiKey = "YOUR_API_KEY",
            environment = Environment.MOCK,
            autoTrackScreens = true,
        )
        UXRate.loggingEnabled = true
    }
}
