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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.9.0/UXRateSDK.xcframework.zip",
            checksum: "213e8d0620214bb5b1ef37f016d42b31dab958a504d8a934c2703a6531e57cb9"
        ),
    ]
)
