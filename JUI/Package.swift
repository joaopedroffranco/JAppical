// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "JUI",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "JUI",
			targets: ["JUI"]),
	],
	dependencies: [
		.package(name: "JFoundation", path: "../JFoundation"),
		.package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.10.0"),
	],
	targets: [
		.target(
			name: "JUI",
			dependencies: ["JFoundation", "Kingfisher"],
			resources: [.process("Resources")]
		)
	]
)
