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
        // Mock environment — works immediately without dashboard setup.
        // Switch to .production with your real API key for live surveys.
        UXRate.configure(
            apiKey: "YOUR_API_KEY",
            environment: .mock,
            overlapStrategy: .showLast
        )

        UXRate.loggingEnabled = true
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
