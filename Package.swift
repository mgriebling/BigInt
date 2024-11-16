// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BigInt",
	platforms: [
		// required to support StaticBigInt - wish there were a way to fallback to Int
		.macOS("13.3"), .iOS("16.4"), .tvOS("16.4"), .watchOS("9.4"),
		.macCatalyst("13.0")
	],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BigInt",
            targets: ["BigInt"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BigInt",
            dependencies: []),
        .testTarget(
            name: "BigIntTests",
            dependencies: ["BigInt"]),
    ]
)
