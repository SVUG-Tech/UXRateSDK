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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.3.0/UXRateSDK.xcframework.zip",
            checksum: "925942b3c80f580b45ab54743b5b59589d26b2bb782b6ec11730b5000640b03e"
        ),
    ]
)
