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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/0.1.0/UXRateSDK.xcframework.zip",
            checksum: "e95496ff30246b2b5da8484fc0286fba793dd2837e9a223e985803c8e8191e60"
        ),
    ]
)
