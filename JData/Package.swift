// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "JData",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "JData",
			targets: ["JData"]),
	],
	dependencies: [
		.package(name: "JFoundation", path: "../JFoundation"),
		.package(url: "https://github.com/realm/realm-swift.git", exact: "10.39.1"),
	],
	targets: [
		.target(
			name: "JData",
			dependencies: ["JFoundation", .product(name: "RealmSwift", package: "realm-swift")]),
		.testTarget(
			name: "JDataTests",
			dependencies: ["JData"],
			resources: [.process("JSONs")]
		),
	]
)
