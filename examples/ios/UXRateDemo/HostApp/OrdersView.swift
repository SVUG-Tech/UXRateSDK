import SwiftUI

struct OrdersView: View {
    private let orders: [(String, String, String, Color)] = [
        ("#10421", "MacBook Pro", "Delivered", .green),
        ("#10398", "AirPods Pro", "Shipped", .blue),
        ("#10375", "iPhone Case", "Processing", .orange),
    ]

    var body: some View {
        List(orders, id: \.0) { id, product, status, color in
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(product).font(.headline)
                    Text(id)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(status)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(color.opacity(0.15))
                    .foregroundStyle(color)
                    .clipShape(Capsule())
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Orders")
    }
}
