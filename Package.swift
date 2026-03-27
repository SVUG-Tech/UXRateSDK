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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.2.0/UXRateSDK.xcframework.zip",
            checksum: "461fbd48fbe055a4d74d22294ccadcae58382150fb8901e11c764cfce5bb0412"
        ),
    ]
)
