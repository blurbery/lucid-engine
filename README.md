# Lucid Engine

Lucid Engine is the media engine of [Vivid](https://github.com/blurbery/vivid), an Apple media client by blurbery. This repository serves it as a Swift package: libmpv, FFmpeg and every library they use, as static xcframeworks for iOS and tvOS, all built from upstream source by Vivid's own pipeline.

## Using it

```swift
.package(url: "https://github.com/blurbery/lucid-engine", revision: "<commit of a release tag>")
```

Add the `LucidEngine` product to the app target and import the frameworks by name, for example `import Libmpv`. The product also links the system frameworks and libraries the engine needs (Vivid's [`engine/config/app-link.txt`](https://github.com/blurbery/vivid/blob/fcb6782121e72c6ed755336be913c036f4679ddb/engine/config/app-link.txt)).

- Slices: `ios-arm64`, `ios-arm64-simulator`, `tvos-arm64` and `tvos-arm64-simulator`. There are no x86_64 simulator, arm64e or macOS slices, so the package supports only these four.
- Platforms: iOS 14 and tvOS 14. Each library keeps its own deployment target, as before: 14.0 for libmpv, FFmpeg, libass, dav1d and libdovi, and 13.0 to 15.0 for the others (uavs3d 15.0; MoltenVK 14.5 on tvOS). Vivid's apps target iOS 18 and tvOS 26.
- The `Libavutil` module does not import, because its module map includes FFmpeg's hardware headers for other platforms (AMF, DRM, MediaCodec and OpenHarmony). Its functions still link.

## Release 0.1.0

Built by Vivid's pipeline from [`blurbery/vivid` at `fcb6782`](https://github.com/blurbery/vivid/tree/fcb6782121e72c6ed755336be913c036f4679ddb/engine) (`fcb6782121e72c6ed755336be913c036f4679ddb`), in GitHub Actions run [38458337996](https://github.com/blurbery/vivid/actions/runs/38458337996). Every library is built from its upstream source with Vivid's patch series; no prebuilt third-party binary is used. The release assets are the 22 xcframework zips (21 frameworks and MoltenVK's static library), `SHA256SUMS` (each zip's SHA-256, which is also its SwiftPM checksum) and the provenance report of each slice.

| Frameworks | Library | Version | Upstream source | Licence as built | Patches |
| --- | --- | --- | --- | --- | --- |
| `Libmpv` | mpv | v0.41.0 (`41f6a645`) | [mpv-player/mpv](https://github.com/mpv-player/mpv) | LGPL-2.1-or-later | [16](https://github.com/blurbery/vivid/tree/fcb6782121e72c6ed755336be913c036f4679ddb/engine/patches/mpv/series) |
| `Libavcodec`, `Libavdevice`, `Libavfilter`, `Libavformat`, `Libavutil`, `Libswresample`, `Libswscale` | FFmpeg | n8.0.1 (`894da5ca`) | [FFmpeg/FFmpeg](https://github.com/FFmpeg/FFmpeg) | LGPL-2.1-or-later | [5](https://github.com/blurbery/vivid/tree/fcb6782121e72c6ed755336be913c036f4679ddb/engine/patches/ffmpeg/series) |
| `Libass` | libass | 0.17.5 (`4a05d812`) | [libass/libass](https://github.com/libass/libass) | ISC | [3](https://github.com/blurbery/vivid/tree/fcb6782121e72c6ed755336be913c036f4679ddb/engine/patches/libass/series) |
| `Libdav1d` | dav1d | 1.5.3 (`b546257f`) | [videolan/dav1d](https://github.com/videolan/dav1d) | BSD-2-Clause | none |
| `Libdovi` | libdovi (`dolby_vision` crate) | 3.3.2 (`4fd2b223`) | [quietvoid/dovi_tool](https://github.com/quietvoid/dovi_tool) | MIT | [1](https://github.com/blurbery/vivid/tree/fcb6782121e72c6ed755336be913c036f4679ddb/engine/patches/libdovi/series) |
| `Libfreetype` | FreeType | 2.12.1 (`e8ebfe98`) | [freetype/freetype](https://github.com/freetype/freetype) | FTL | none |
| `Libfribidi` | GNU FriBidi | 1.0.12 (`6428d846`) | [fribidi/fribidi](https://github.com/fribidi/fribidi) | LGPL-2.1-or-later | none |
| `Libharfbuzz` | HarfBuzz | 8.1.1 (`1d665c2b`) | [harfbuzz/harfbuzz](https://github.com/harfbuzz/harfbuzz) | MIT | none |
| `Libunibreak` | libunibreak | 6.1 (`304585d8`) | [adah1972/libunibreak](https://github.com/adah1972/libunibreak) | Zlib | none |
| `lcms2` | Little CMS | 2.17 (`51763476`) | [mm2/Little-CMS](https://github.com/mm2/Little-CMS) | MIT | none |
| `Libshaderc_combined` | shaderc | 2025.5 (`c4b0af6c`) | [google/shaderc](https://github.com/google/shaderc) | Apache-2.0 | none |
| `MoltenVK` | MoltenVK | 1.4.1 (`db445ff2`) | [KhronosGroup/MoltenVK](https://github.com/KhronosGroup/MoltenVK) | Apache-2.0 | none |
| `Libplacebo` | libplacebo | 7.351.0 (`3188549f`) | [haasn/libplacebo](https://github.com/haasn/libplacebo) | LGPL-2.1-or-later | none |
| `Libuavs3d` | uavs3d | 1.2 (`0e20d2c2`) | [uavs3/uavs3d](https://github.com/uavs3/uavs3d) | BSD-3-Clause | [1](https://github.com/blurbery/vivid/tree/fcb6782121e72c6ed755336be913c036f4679ddb/engine/patches/uavs3d/series) |
| `Libbluray` | libbluray | 1.4.0 (`9f07fbb2`) | [videolan/libbluray](https://code.videolan.org/videolan/libbluray) | LGPL-2.1-or-later | [1](https://github.com/blurbery/vivid/tree/fcb6782121e72c6ed755336be913c036f4679ddb/engine/patches/libbluray/series) |
| `Libuchardet` | uchardet | 0.0.8 (`ae6302a0`) | [uchardet/uchardet](https://gitlab.freedesktop.org/uchardet/uchardet) | LGPL-2.1-or-later (one of three) | none |

The patch series are in [`engine/patches`](https://github.com/blurbery/vivid/tree/fcb6782121e72c6ed755336be913c036f4679ddb/engine/patches). Vivid's own patches are licensed like the library they patch: LGPL-2.1-or-later for mpv, FFmpeg and libbluray, ISC for libass, MIT for libdovi and BSD-3-Clause for uavs3d. mpv `0001` and libass `0001` and `0002` are upstream changes, unchanged, with their upstream attribution. FFmpeg uses Apple's Secure Transport for TLS; there is no OpenSSL.

## Rebuilding

The build runs in Vivid's [Lucid Engine build workflow](https://github.com/blurbery/vivid/blob/fcb6782121e72c6ed755336be913c036f4679ddb/.github/workflows/lucid-engine.yml) with [`engine/lucid.py`](https://github.com/blurbery/vivid/blob/fcb6782121e72c6ed755336be913c036f4679ddb/engine/lucid.py), and this package is written by [`engine/publish_package.py`](https://github.com/blurbery/vivid/blob/fcb6782121e72c6ed755336be913c036f4679ddb/engine/publish_package.py) from that run's artefacts. Every download is pinned by URL and SHA-256 in `engine/pins.ini`. The [build guide](https://github.com/blurbery/vivid/blob/fcb6782121e72c6ed755336be913c036f4679ddb/docs/cores/lucid-engine-build.md) at the same commit describes the steps, the checks and the outputs. The builds are reproducible: unchanged inputs give byte-identical zips across CI runs, so a rebuild at `fcb6782` with the same Xcode should match `SHA256SUMS`.

## Licences

Each library keeps its own licence. [`NOTICE`](NOTICE) lists every library with its version, upstream commit and licence, including the code the libraries contain from other projects. The licence texts are in [`LICENSES`](LICENSES), taken from the upstream source at the listed commits. This repository's own files (`Package.swift`, `Sources`, this README and `NOTICE`) are licensed under LGPL-2.1-or-later; see [`LICENSE`](LICENSE).

Maintainer: blurbery.
