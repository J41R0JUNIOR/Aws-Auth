// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription

let package = Package(
    name: "Auth_Aws_Package",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Auth_Aws_Package",
            targets: ["Auth_Aws_Package"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/J41R0JUNIOR/ViewProtocol_Package", branch: "main")
    ],
    targets: [
        .target(
            name: "Auth_Aws_Package",
            dependencies: [
                .product(name: "ViewProtocol_Package", package: "ViewProtocol_Package")
            ]
        ),
    
    ]
)

