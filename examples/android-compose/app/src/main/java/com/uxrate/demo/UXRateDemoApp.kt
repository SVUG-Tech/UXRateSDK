package com.uxrate.demo

import android.app.Application
import com.uxrate.sdk.UXRate

/**
 * Application class — configures the UXRate SDK at startup.
 *
 * Demonstrates the minimal integration:
 *   1. Call UXRate.configure() once in Application.onCreate()
 *   2. Call UXRate.identify() after the user is known
 *   3. Screen names are auto-tracked from Activity class names
 */
class UXRateDemoApp : Application() {
    override fun onCreate() {
        super.onCreate()

        // Replace with your API key from the UXRate dashboard
        UXRate.configure(
            application = this,
            apiKey = "YOUR_API_KEY"
        )

        // Enable debug logging for development
        UXRate.loggingEnabled = true

        // Identify a demo user — properties can be used in user_segment trigger rules
        UXRate.identify(
            userId = "android-user-1",
            properties = mapOf("platform" to "android", "plan" to "pro")
        )
    }
}
