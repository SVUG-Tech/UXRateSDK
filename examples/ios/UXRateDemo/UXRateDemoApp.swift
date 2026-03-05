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
        UXRate.configure(apiKey: "uxr_e6e454661622ad160d6261ee30160f423370fb8430463af04dea81d29ae0a606")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
