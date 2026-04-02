// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "UXRateSDK",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "UXRateSDK", targets: ["UXRateSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "UXRateSDK",
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.2.2/UXRateSDK.xcframework.zip",
            checksum: "92698770b7f72a47ee245efd9c3e0a9b4b693fb5cb0b7af77f412de710b6714f"
        ),
    ]
)
