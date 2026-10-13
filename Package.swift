// swift-tools-version:5.9
//
// Lucid Engine 0.1.0: libmpv, FFmpeg and every library they use, built
// from upstream source by Vivid's pipeline at blurbery/vivid
// fcb6782121e72c6ed755336be913c036f4679ddb. See README.md.

import PackageDescription

/// Release assets of this repository, built by Vivid's pipeline.
let release = "https://github.com/blurbery/lucid-engine/releases/download/v0.1.0"

/// A framework (or MoltenVK's static library) Vivid's pipeline builds. The
/// checksum is the SHA-256 of the zip, as listed in the release's
/// `SHA256SUMS`.
func built(_ name: String, _ checksum: String) -> Target {
    .binaryTarget(name: name, url: "\(release)/\(name).xcframework.zip", checksum: checksum)
}

let binaries: [Target] = [
    built("Libass", "a98b5c01efe7bc7b303d83c0843086fae9e968f03c7b52b2113ac0e28f36445d"),
    built("Libavcodec", "88828e68995141a2a2bc55af33ed16b4e7f9a69ec7a214e9d73e6b4bcb921524"),
    built("Libavdevice", "c241a1d6db3b607e7d3cc119f1cd736bbc2c76d28b9ea8d296eaa846ec1bac8a"),
    built("Libavfilter", "a3bf2db8bd584a99bb58ce7a60a55f6b51001781dd151a35fbd5702b647ff5a2"),
    built("Libavformat", "518949709d7d197e73941d0967e445f0e7d7d6346b0091c1e765e8536141621b"),
    built("Libavutil", "845145378d316e46ba7849c1018bd7aa46eec86c16a9f0ac87533636bd0a0355"),
    built("Libbluray", "ac5ad1d89a1faa4f67b41fedf8bf8bde1189bc68fc78094a594c3f52fb1c8fdd"),
    built("Libdav1d", "364cd65dabc5a3c5a58f137b82773b9c30cba05181ea58a65abec0d5e3191875"),
    built("Libdovi", "731f0052253b52047ce94f9ecddefc81001a49c059c31cd9d45a5a9f4897cbd3"),
    built("Libfreetype", "59046c5906a795668e39ff673c7617b57a6cd62b3f0715b942747ace27bfa163"),
    built("Libfribidi", "c273ccf00d36e9197cad74dd930e95cb2043755d9777ac38ff1c32ced471cba6"),
    built("Libharfbuzz", "fe6cd6ea684167ba9a1f3371247acfb4da487b9ecd5634163c0359b003482d8d"),
    built("Libmpv", "dda977835937c6c4300143671e1b1b4179f66fa09a5e50695a7fdcda7b99fb61"),
    built("Libplacebo", "c2d1af5f633e841ee30865c8f474829b66255f577f82820eb405c3c78adb7023"),
    built("Libshaderc_combined", "94c2b42ef1b3bb82b5537da5395c294b7c648cb8070e5d1804e32f8803100cb7"),
    built("Libswresample", "e3342fced61539b00770ffb7de9e7a6c1967180b4f25796cda4a6be504639883"),
    built("Libswscale", "dbee40df00d4c1a15d160fd753da4eec9224a9a424f5b5cc7d173f991bd328f0"),
    built("Libuavs3d", "208fc6ea5919c2642a544eac8081fa553f1c91e725d5a70414024bbb20dc21c4"),
    built("Libuchardet", "24883f9146b076ceafe747710cdc5fcf5aec6c2472d327c954404f404b6253fd"),
    built("Libunibreak", "7df693945c8ffa6d7f745af6a97f4bcced640feee153d7066fd41f505389322d"),
    built("MoltenVK", "d8faaffe58b0e50eb74d23adc2191050789d0857b90986d7581711d9c821b0dc"),
    built("lcms2", "988fb88d0a9f5b23916d12c12202244d65847848687beecdfcaff1a2898e2f04"),
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
