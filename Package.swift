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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.6.0/UXRateSDK.xcframework.zip",
            checksum: "1769b22f4ba061d4b2b6d37d5176d30a62e0f8e22301c131fb2a9cbbf8693a17"
        ),
    ]
)
