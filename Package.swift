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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.8.1/UXRateSDK.xcframework.zip",
            checksum: "72d69be52fd22c28254a6f107fa45ae6b8da7d2fd6dae667423baff3c526f749"
        ),
    ]
)
