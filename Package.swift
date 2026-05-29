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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.8.2/UXRateSDK.xcframework.zip",
            checksum: "7082f0034b5ac669f385f2b62ade4aba37406a84b505c24ddc94635ba6480c00"
        ),
    ]
)
