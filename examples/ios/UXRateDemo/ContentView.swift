//
//  ContentView.swift
//  UXRateDemo
//

import SwiftUI
import UXRateSDK

struct ContentView: View {
    var body: some View {
        if #available(iOS 18.0, *) {
            TabView {
                Tab("Home", systemImage: "house") {
                    HomeView()
                }
                Tab("Profile", systemImage: "person") {
                    ProfileView()
                }
                Tab("Settings", systemImage: "gear") {
                    SettingsView()
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    ContentView()
}
