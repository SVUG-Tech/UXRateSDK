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
        // Replace with your API key from the UXRate dashboard
        UXRate.configure(
            apiKey: "YOUR_API_KEY",
            overlapStrategy: .showLast
        )

        // Use a unique ID per install so completed interviews don't block retesting
        let demoUserId = "ios-demo-\(UUID().uuidString.prefix(8).lowercased())"
        UXRate.identify(
            userId: demoUserId,
            properties: ["platform": "ios", "plan": "pro"]
        )

        UXRate.loggingEnabled = true
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
