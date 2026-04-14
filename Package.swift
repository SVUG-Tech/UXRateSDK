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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.5.0/UXRateSDK.xcframework.zip",
            checksum: "38662a0797f57e4e17f5491dedfcf35e3a8f290846c03d2452824a19083b3e9e"
        ),
    ]
)
