import SwiftUI

struct NotificationsView: View {
    private let notifications = [
        ("Order Shipped", "Your MacBook Pro is on the way!", "shippingbox.fill", "2m ago"),
        ("Flash Sale", "50% off accessories today only", "tag.fill", "1h ago"),
        ("Review Request", "How was your recent purchase?", "star.fill", "3h ago"),
        ("Payment Confirmed", "Your payment of $249 was processed", "creditcard.fill", "1d ago"),
        ("New Arrival", "Check out the latest products", "sparkles", "2d ago"),
    ]

    var body: some View {
        List(notifications, id: \.0) { title, subtitle, icon, time in
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.orange)
                    .frame(width: 32)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(title).font(.headline)
                        Spacer()
                        Text(time)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Notifications")
    }
}
