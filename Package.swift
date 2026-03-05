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
            url: "https://github.com/SVUG-Tech/UXRateSDK/releases/download/0.1.2/UXRateSDK.xcframework.zip",
            checksum: "868fade927832d4c5cb18853d98f9b3804a4fcc0d7b047bc0de4c9ed46d32318"
        ),
    ]
)
