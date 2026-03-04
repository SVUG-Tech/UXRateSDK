//
//  ContentView.swift
//  UXRateDemo
//

import SwiftUI
import UXRateSDK

struct ContentView: View {
    var body: some View {
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
    }
}

#Preview {
    ContentView()
}
