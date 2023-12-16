// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "PyCamera",
	platforms: [.iOS(.v13)],
	products: [
		.library(name: "PyCamera", targets: ["PyCamera"])
	],
	dependencies: [
        .package(url: "https://github.com/KivySwiftLink/PythonSwiftLink", from: .init(311, 0, 0)),
        .package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", from: .init(0, 0, 0)),
		.package(url: "https://github.com/KivySwiftPackages/PyCoreVideo", from: .init(311, 0, 0)),
	],
	targets: [
		.target(
			name: "PyCamera",
			dependencies: [
                .product(name: "SwiftonizeModules", package: "PythonSwiftLink"),
                .product(name: "PyCoreVideo", package: "PyCoreVideo"),
			],
			plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),

	]
)
