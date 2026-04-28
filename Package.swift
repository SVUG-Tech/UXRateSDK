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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.7.0/UXRateSDK.xcframework.zip",
            checksum: "4ff007afcc455834bead79b50eb88a2ea12183a41867465a413f3a4ae5789ec0"
        ),
    ]
)
