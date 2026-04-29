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
        // Mock service — works immediately without dashboard setup.
        // Replace `apiKey: "mock"` with your real API key (uxr_…) for live surveys;
        // the SDK auto-resolves the backend from the key prefix.
        UXRate.configure(
            apiKey: "mock",
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
