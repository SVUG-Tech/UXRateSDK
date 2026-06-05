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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.8.3/UXRateSDK.xcframework.zip",
            checksum: "5e0b8e2e441df1e6511ab292121ecf0dabac71c26351d4f7e369ff25f25868c5"
        ),
    ]
)
