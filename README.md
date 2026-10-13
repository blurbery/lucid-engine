# Lucid Engine

Lucid Engine is the media engine of [Vivid](https://github.com/blurbery/vivid), an Apple media client by blurbery. This repository serves it as a Swift package: libmpv, FFmpeg and the libraries they use, as static xcframeworks for iOS and tvOS.

## Using it

```swift
.package(url: "https://github.com/blurbery/lucid-engine", revision: "<commit of a release tag>")
```

Add the `LucidEngine` product to the app target and import the frameworks by name, for example `import Libmpv`. The product also links the system frameworks and libraries the engine needs (Vivid's [`engine/config/app-link.txt`](https://github.com/blurbery/vivid/blob/10faa2a8b45d683380e8e452638be2d9c4c8a3cd/engine/config/app-link.txt)).

- Slices: `ios-arm64`, `ios-arm64-simulator`, `tvos-arm64` and `tvos-arm64-simulator`. Vivid's builds have no x86_64 simulator, arm64e or macOS slices, so the package supports only these four.
- Minimum OS: iOS 14.0 and tvOS 14.0.
- The `Libavutil` module does not import, because its module map includes FFmpeg's hardware headers for other platforms (AMF, DRM, MediaCodec and OpenHarmony). Its functions still link.

## Release 0.1.0-interim.1

Built by Vivid's pipeline from [`blurbery/vivid` at `10faa2a`](https://github.com/blurbery/vivid/tree/10faa2a8b45d683380e8e452638be2d9c4c8a3cd/engine) (`10faa2a8b45d683380e8e452638be2d9c4c8a3cd`), in GitHub Actions run [38400124717](https://github.com/blurbery/vivid/actions/runs/38400124717). The release assets are the eleven xcframework zips, `SHA256SUMS` (each zip's SHA-256, which is also its SwiftPM checksum) and the provenance report of each slice.

| Frameworks | Library | Version | Upstream source | Licence as built |
| --- | --- | --- | --- | --- |
| `Libmpv` | mpv | v0.41.0 (`41f6a645`) | [mpv-player/mpv](https://github.com/mpv-player/mpv) | LGPL-2.1-or-later (`-Dgpl=false`) |
| `Libavcodec`, `Libavdevice`, `Libavfilter`, `Libavformat`, `Libavutil`, `Libswresample`, `Libswscale` | FFmpeg | n8.0.1 (`894da5ca`) | [FFmpeg/FFmpeg](https://github.com/FFmpeg/FFmpeg) | LGPL-2.1-or-later |
| `Libass` | libass | 0.17.5 (`4a05d812`) | [libass/libass](https://github.com/libass/libass) | ISC |
| `Libdav1d` | dav1d | 1.5.3 (`b546257f`) | [videolan/dav1d](https://github.com/videolan/dav1d) | BSD-2-Clause |
| `Libdovi` | libdovi (`dolby_vision` crate) | 3.3.2 (`4fd2b223`) | [quietvoid/dovi_tool](https://github.com/quietvoid/dovi_tool) | MIT |

The pipeline applies Vivid's patch series in [`engine/patches`](https://github.com/blurbery/vivid/tree/10faa2a8b45d683380e8e452638be2d9c4c8a3cd/engine/patches) to mpv, FFmpeg and libdovi. Vivid's own patches are licensed under LGPL-2.1-or-later, except the libdovi patch, which is MIT. FFmpeg uses Apple's Secure Transport for TLS; there is no OpenSSL.

### Interim libraries

Eleven libraries are not built from source by Vivid's pipeline yet. For this release only, `Package.swift` uses the prebuilt binaries at the `xcframework_url` and `xcframework_sha256` pinned in [`engine/pins.ini`](https://github.com/blurbery/vivid/blob/10faa2a8b45d683380e8e452638be2d9c4c8a3cd/engine/pins.ini). They are not hosted here. A later release replaces them with Vivid's own source builds.

| Framework | Library | Version | Upstream source | Licence |
| --- | --- | --- | --- | --- |
| `Libfreetype` | FreeType | 2.12.1 | [freetype/freetype](https://github.com/freetype/freetype) | FTL |
| `Libfribidi` | GNU FriBidi | 1.0.12 | [fribidi/fribidi](https://github.com/fribidi/fribidi) | LGPL-2.1-or-later |
| `Libharfbuzz` | HarfBuzz | 8.1.1 | [harfbuzz/harfbuzz](https://github.com/harfbuzz/harfbuzz) | MIT |
| `Libunibreak` | libunibreak | 6.1 | [adah1972/libunibreak](https://github.com/adah1972/libunibreak) | Zlib |
| `Libplacebo` | libplacebo | 7.351.0 | [haasn/libplacebo](https://github.com/haasn/libplacebo) | LGPL-2.1-or-later |
| `lcms2` | Little CMS | 2.17 | [mm2/Little-CMS](https://github.com/mm2/Little-CMS) | MIT |
| `MoltenVK` | MoltenVK | 1.4.1 | [KhronosGroup/MoltenVK](https://github.com/KhronosGroup/MoltenVK) | Apache-2.0 |
| `Libshaderc_combined` | shaderc | 2025.5 | [google/shaderc](https://github.com/google/shaderc) | Apache-2.0 |
| `Libuavs3d` | uavs3d | 1.2 | [uavs3/uavs3d](https://github.com/uavs3/uavs3d) | BSD-3-Clause |
| `Libbluray` | libbluray | 1.4.0 | [videolan/libbluray](https://code.videolan.org/videolan/libbluray) | LGPL-2.1-or-later |
| `Libuchardet` | uchardet | 0.0.8 | [uchardet/uchardet](https://gitlab.freedesktop.org/uchardet/uchardet) | LGPL-2.1-or-later (of MPL-1.1, GPL-2.0-or-later or LGPL-2.1-or-later) |

## Rebuilding

The build runs in Vivid's [Lucid Engine build workflow](https://github.com/blurbery/vivid/blob/10faa2a8b45d683380e8e452638be2d9c4c8a3cd/.github/workflows/lucid-engine.yml) with [`engine/lucid.py`](https://github.com/blurbery/vivid/blob/10faa2a8b45d683380e8e452638be2d9c4c8a3cd/engine/lucid.py). Every download is pinned by URL and SHA-256 in `engine/pins.ini`. The [build guide](https://github.com/blurbery/vivid/blob/10faa2a8b45d683380e8e452638be2d9c4c8a3cd/docs/cores/lucid-engine-build.md) at the same commit describes the steps, the checks and the outputs. The builds are reproducible: unchanged inputs gave byte-identical zips across CI runs, so a rebuild at `10faa2a` with the same Xcode should match `SHA256SUMS`.

## Licences

Each library keeps its own licence. [`NOTICE`](NOTICE) lists every library with its version, upstream commit and licence, including the code the libraries contain from other projects. The licence texts are in [`LICENSES`](LICENSES), taken from the upstream source at the listed commits.

Maintainer: blurbery.
