import SwiftUI

struct ProductsView: View {
    private let products = [
        ("MacBook Pro", "laptop", "$1,999"),
        ("iPhone 17 Pro", "iphone", "$1,199"),
        ("AirPods Pro", "airpodspro", "$249"),
        ("Apple Watch", "applewatch", "$399"),
        ("iPad Air", "ipad", "$599"),
    ]

    var body: some View {
        List(products, id: \.0) { name, icon, price in
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title2)
                    .frame(width: 40)
                    .foregroundStyle(.blue)
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                    Text(price)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Products")
        .surveyScreen("Products")
    }
}
