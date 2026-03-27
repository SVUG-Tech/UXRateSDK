import SwiftUI
import UIKit
import UXRateSDK

/// SwiftUI profile view embedded in UIKit via UIHostingController.
///
/// The SDK auto-detects this as "ProfileContentView" from the generic type
/// parameter: `UIHostingController<ProfileContentView>`.
class ProfileViewController: UIHostingController<ProfileContentView> {
    init() {
        super.init(rootView: ProfileContentView())
    }

    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UXRate.track(event: "screen_viewed", properties: ["screen": "Profile"])
    }
}

// MARK: - SwiftUI View

struct ProfileContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)
            Text("Profile Screen")
                .font(.title)
            Text("This SwiftUI view is embedded via UIHostingController.\nThe SDK auto-detects it as \"ProfileContentView\".")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Profile")
    }
}
