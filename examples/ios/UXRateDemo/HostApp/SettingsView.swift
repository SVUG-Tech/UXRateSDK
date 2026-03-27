import SwiftUI
import UXRateSDK

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.gray)
                Text("Settings Screen")
                    .font(.title)
                Text("No survey button here (not in backend config).")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Settings")
            .onAppear {
                UXRate.track(event: "screen_viewed", properties: ["screen": "Settings"])
            }
        }
    }
}
