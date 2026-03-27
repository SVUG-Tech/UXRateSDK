import SwiftUI
import UXRateSDK

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.green)
                Text("Profile Screen")
                    .font(.title)
                Text("The survey button should appear here too.")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Profile")
            .onAppear {
                UXRate.track(event: "screen_viewed", properties: ["screen": "Profile"])
            }
        }
    }
}
