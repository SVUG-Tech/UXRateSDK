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

        // Mock service — works immediately without dashboard setup.
        // Replace `apiKey = "mock"` with your real API key (uxr_…) for live surveys;
        // the SDK auto-resolves the backend from the key prefix.
        UXRate.configure(
            application = this,
            apiKey = "mock"
        )

        UXRate.loggingEnabled = true
    }
}
