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
            url: "https://github.com/umutafacan/UXRateSDK/releases/download/0.1.0/UXRateSDK.xcframework.zip",
            checksum: "PLACEHOLDER"
        ),
    ]
)
