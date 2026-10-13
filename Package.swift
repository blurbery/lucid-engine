// swift-tools-version:5.9
//
// Lucid Engine 0.1.0-interim.1: libmpv, FFmpeg, libass, dav1d and libdovi
// built from upstream source by Vivid's pipeline at blurbery/vivid
// 10faa2a8b45d683380e8e452638be2d9c4c8a3cd, plus eleven interim prebuilt
// libraries. See README.md.

import PackageDescription

/// Release assets of this repository, built by Vivid's pipeline.
let release = "https://github.com/blurbery/lucid-engine/releases/download/v0.1.0-interim.1"

/// A framework Vivid's pipeline builds. The checksum is the SHA-256 of the
/// zip, as listed in the release's `SHA256SUMS`.
func built(_ name: String, _ checksum: String) -> Target {
    .binaryTarget(name: name, url: "\(release)/\(name).xcframework.zip", checksum: checksum)
}

/// An interim prebuilt framework, at the `xcframework_url` and
/// `xcframework_sha256` pinned in Vivid's `engine/pins.ini`. A later release
/// replaces each one with Vivid's own source build.
func interim(_ name: String, _ url: String, _ checksum: String) -> Target {
    .binaryTarget(name: name, url: url, checksum: checksum)
}

let binaries: [Target] = [
    // Built from source by Vivid's pipeline.
    built("Libmpv", "2fd41b68418c61d202109d72e1b151fd9fb75acb457a3f956615320312319cf9"),
    built("Libavcodec", "2e35124cecf42ddd5e36a2d79965980de370c69e288581dabbdf25f6167288a6"),
    built("Libavdevice", "35d0755b46f6ab66c5a46b0ac3880d9b45565a6ab851d431af186f62466763d8"),
    built("Libavfilter", "6462f4a9bd41e3a70a657ed3171c7164147263b76966c8bfd9a23f4b7e2ad4dd"),
    built("Libavformat", "99b8716bd2add245f953e6196505b489daf38f4c679f2289a58c59efc93e0272"),
    built("Libavutil", "b194b83f8f2f486325fa958889c929886a9f7bdc9bb3ccf1ef8ee1a4a1cc8854"),
    built("Libswresample", "9a10997fd5b2277f93f57f4f11e6a6941994b01c7f33f4a1038b227a01addfbd"),
    built("Libswscale", "9a4b327b69d526364ddd7e7b6dfdda6998aa795178fe4aab22ca10253594623b"),
    built("Libass", "ff1042a1e988f77d865a87dc1a143865407d3a81d531fcc1d6f7221ca733e5bd"),
    built("Libdav1d", "ebe6f8ef385fae75fbca66905d270366dd9d1ae67fd8fff76c07d5f719f9fe4e"),
    built("Libdovi", "393775c5d24b3520aa244cb867087d2a5f6d3f2a5c0a05465bacce59d9c1b37e"),

    // Interim prebuilt binaries, not yet built from source by the pipeline.
    interim(
        "Libfreetype",
        "https://github.com/mpvkit/libass-build/releases/download/0.17.4/Libfreetype.xcframework.zip",
        "f2840aba1ce35e51c0595557eee82c908dac8e32108ecc0661301c06061e051c"
    ),
    interim(
        "Libfribidi",
        "https://github.com/mpvkit/libass-build/releases/download/0.17.4/Libfribidi.xcframework.zip",
        "4a55513792ef7a17893875f74cc84c56f3657e8768c07a7a96f563a11dc4b743"
    ),
    interim(
        "Libharfbuzz",
        "https://github.com/mpvkit/libass-build/releases/download/0.17.4/Libharfbuzz.xcframework.zip",
        "91558d8497d9d97bc11eeef8b744d104315893bfee8f17483d8002e14565f84b"
    ),
    interim(
        "Libunibreak",
        "https://github.com/mpvkit/libass-build/releases/download/0.17.4/Libunibreak.xcframework.zip",
        "001087c0e927ae00f604422b539898b81eb77230ea7700597b70393cd51e946c"
    ),
    interim(
        "Libplacebo",
        "https://github.com/mpvkit/libplacebo-build/releases/download/7.351.0-2512/Libplacebo.xcframework.zip",
        "3b2bd57b82549566963effadf0891a141448d9f89c7d48fca0b8f823b854bac6"
    ),
    interim(
        "lcms2",
        "https://github.com/mpvkit/lcms2-build/releases/download/2.17.0/lcms2.xcframework.zip",
        "dc0dce0606f6ab6841a8ec5a6bd4448e2f3ef00661a050460f806c9393dc6982"
    ),
    interim(
        "MoltenVK",
        "https://github.com/mpvkit/moltenvk-build/releases/download/1.4.1/MoltenVK.xcframework.zip",
        "9bd1ca1e4563bacd25d6e55d37b10341d50b2601bc2684bc332188e79daa2b79"
    ),
    interim(
        "Libshaderc_combined",
        "https://github.com/mpvkit/libshaderc-build/releases/download/2025.5.0/Libshaderc_combined.xcframework.zip",
        "758047b615708575b580eb960a2d083f760a29dc462d6eaa360416c946ce433b"
    ),
    interim(
        "Libuavs3d",
        "https://github.com/mpvkit/libuavs3d-build/releases/download/1.2.1-fix/Libuavs3d.xcframework.zip",
        "bd5256081486d16c51c868d755bf70266c424b54c895269580de44ec6707f789"
    ),
    interim(
        "Libbluray",
        "https://github.com/mpvkit/libbluray-build/releases/download/1.4.0/Libbluray.xcframework.zip",
        "bc037d34e2b0b5ab7f202fb371f5fb298136cc66fdf406c2172185d06f53f18d"
    ),
    interim(
        "Libuchardet",
        "https://github.com/mpvkit/libuchardet-build/releases/download/0.0.8-xcode/Libuchardet.xcframework.zip",
        "503202caa0dafb6996b2443f53408a713b49f6c2d4a26d7856fd6143513a50d7"
    ),
]

let binaryNames = binaries.map(\.name)

let package = Package(
    name: "LucidEngine",
    platforms: [.iOS(.v14), .tvOS(.v14)],
    products: [
        // Every framework, plus the wrapper that links the system frameworks
        // and libraries they need. Import the frameworks by name, for example
        // `import Libmpv`.
        .library(name: "LucidEngine", targets: ["LucidEngine"] + binaryNames),
    ],
    targets: [
        .target(
            name: "LucidEngine",
            dependencies: binaryNames.map { .target(name: $0) },
            // Exactly the system frameworks and libraries of Vivid's
            // engine/config/app-link.txt, which the pipeline's link test uses.
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("VideoToolbox"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("AudioToolbox"),
                .linkedFramework("CoreAudio"),
                .linkedFramework("Security"),
                .linkedFramework("Metal"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("CoreText"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("UIKit"),
                .linkedFramework("OpenGLES"),
                .linkedFramework("IOSurface"),
                .linkedFramework("CoreImage"),
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedLibrary("bz2"),
                .linkedLibrary("iconv"),
                .linkedLibrary("xml2"),
            ]
        ),
    ] + binaries
)
