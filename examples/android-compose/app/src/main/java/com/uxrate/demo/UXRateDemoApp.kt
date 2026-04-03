package com.uxrate.demo

import android.app.Application
import com.uxrate.sdk.UXRate
import com.uxrate.sdk.models.Environment

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

        // Mock environment — works immediately without dashboard setup.
        // Switch to Environment.PRODUCTION with your real API key for live surveys.
        UXRate.configure(
            application = this,
            apiKey = "YOUR_API_KEY",
            environment = Environment.MOCK
        )

        UXRate.loggingEnabled = true
    }
}
