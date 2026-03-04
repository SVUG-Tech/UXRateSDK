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
        UXRate.configure(
            apiKey: "YOUR_API_KEY",
            baseURL: URL(string: "https://api.uxrate.app")!,
            autoTrackScreens: true
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
