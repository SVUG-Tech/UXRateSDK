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
            checksum: "ad1934abd0a5c1606f946195af81d85d77d483d9b88d66e6f60da86337da7bef"
        ),
    ]
)
