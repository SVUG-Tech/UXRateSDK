import SwiftUI
import UXRateSDK

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: ProductsView()) {
                        Label("Products", systemImage: "bag.fill")
                    }
                    NavigationLink(destination: OrdersView()) {
                        Label("Orders", systemImage: "shippingbox.fill")
                    }
                    NavigationLink(destination: NotificationsView()) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                } header: {
                    Text("Browse")
                }

                Section {
                    HStack {
                        Text("Survey button visible")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                } header: {
                    Text("Status")
                } footer: {
                    Text("The floating survey button appears on screens enabled by the backend configuration.")
                }
            }
            .navigationTitle("Home")
            .surveyScreen("Home")
            .onAppear {
                UXRate.track(event: "screen_viewed", properties: ["screen": "Home"])
            }
        }
    }
}
