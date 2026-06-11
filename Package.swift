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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.8.4/UXRateSDK.xcframework.zip",
            checksum: "86c60692962f1d178840cca4f46a189e82a3d7c367b3366ee49c2b458ec75528"
        ),
    ]
)
