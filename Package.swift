// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let kivy = true
let local = false

let pykit_package: Package.Dependency = if kivy {
    .package(url: "https://github.com/KivySwiftLink/PySwiftKit", from: .init(311, 0, 0))
} else {
    if local {
        .package(path: "/Users/codebuilder/Documents/GitHub/PySwiftKit")
    } else {
        .package(url: "https://github.com/PythonSwiftLink/PySwiftKit", from: .init(311, 0, 0))
    }
}

let pykit: Target.Dependency = if kivy {
    .product(name: "SwiftonizeModules", package: "PySwiftKit")
} else {
    .product(name: "SwiftonizeModules", package: "PySwiftKit")
}

let pyvideo_package: Package.Dependency = if kivy {
    if local {
        .package(path: "../PyCoreVideo")
    } else {
        .package(url: "https://github.com/KivySwiftPackages/PyCoreVideo", from: .init(311, 0, 0))
    }
} else {
    if local {
        .package(path: "../PyCoreVideo")
    } else {
        .package(url: "https://github.com/KivySwiftPackages/PyCoreVideo", from: .init(311, 0, 0))
    }
}

let package_deps: [Package.Dependency] = [
    pykit_package,
    pyvideo_package
]


let package = Package(
	name: "PyCamera",
	platforms: [.iOS(.v13)],
	products: [
		.library(name: "PyCamera", targets: ["PyCamera"])
	],
	dependencies: [
        .package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", from: .init(0, 0, 0))
    ] + package_deps,
	targets: [
		.target(
			name: "PyCamera",
			dependencies: [
                pykit,
                .product(name: "PyCoreVideo", package: "PyCoreVideo"),
			],
			plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),

	]
)
