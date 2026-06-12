//
//  UXRateDemoApp.swift
//  UXRateDemo
//
//  Demonstrates the minimal UXRate SDK integration in a SwiftUI app.
//

import SwiftUI
import UXRateSDK

@main
struct UXRateDemoApp: App {
    init() {
        // Use your API key from the dashboard; the SDK auto-resolves
        // the backend from the key prefix (uxr_… / uxr_dev_… / uxr_loc_…).
        UXRate.configure(
            apiKey: "uxr_your_api_key"
        )

        UXRate.loggingEnabled = true
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
