// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let local = false

let pykit_package: Package.Dependency = if local {
    .package(path: "/Users/codebuilder/Documents/GitHub/PySwiftKit")
} else {
    .package(url: "https://github.com/KivySwiftLink/PySwiftKit", from: .init(311, 0, 0))
}

let pyvideo_package: Package.Dependency =
    if local {
        .package(path: "../PyCoreVideo")
    } else {
        .package(url: "https://github.com/KivySwiftPackages/PyCoreVideo", from: .init(311, 0, 0))
    }

let kivytex_package: Package.Dependency =
    if local {
        .package(path: "../KivyTexture")
    } else {
        .package(url: "https://github.com/KivySwiftPackages/KivyTexture", from: .init(311, 0, 0))
    }

let pyfile_package: Package.Dependency = if local {
    .package(path: "../PyFileGenerator")
} else {
    .package(url: "https://github.com/PythonSwiftLink/PyFileGenerator", from: .init(0, 0, 1))
}


let package_deps: [Package.Dependency] = [
    pykit_package,
    pyvideo_package,
    kivytex_package,
    pyfile_package
]


let package = Package(
	name: "PyCamera",
	platforms: [.iOS(.v13)],
	products: [
		.library(name: "PyCamera", targets: ["PyCamera"])
	],
	dependencies: [
        //.package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", from: .init(0, 0, 0))
    ] + package_deps,
	targets: [
		.target(
			name: "PyCamera",
			dependencies: [
                .product(name: "SwiftonizeModules", package: "PySwiftKit"),
                .product(name: "PyCoreVideo", package: "PyCoreVideo"),
                "KivyTexture"
			]//,
			//plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),

	]
)
