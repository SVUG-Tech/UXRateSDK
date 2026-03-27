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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/ios-0.2.1/UXRateSDK.xcframework.zip",
            checksum: "508168c34cdb079d6b19e7b7e7a366f94efbf72fa1f7539e7f4cfff851d35a7e"
        ),
    ]
)
