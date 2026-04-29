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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.8.0/UXRateSDK.xcframework.zip",
            checksum: "768a4c461e2ac33be72403174bcd396938343aaeebd213053aa908f7e6d611df"
        ),
    ]
)
