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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/0.1.1/UXRateSDK.xcframework.zip",
            checksum: "daa4bdecafcd50b395798816f2f23b06a343e69cffd6309f18deefaab0e0ba95"
        ),
    ]
)
