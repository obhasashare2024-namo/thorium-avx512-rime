# Thorium Browser 151 (Skylake-AVX512 & RIME Edition)

[![Architecture](https://img.shields.io/badge/Architecture-Skylake--AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-RIME%20%2F%20Fcitx5-orange.svg)](#rime--fcitx5-chinese-input-integration)
[![GPU](https://img.shields.io/badge/GPU-RTX%203070%20%2F%20VA--API-purple.svg)](#hardware-acceleration--gpu-offloading)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [Support Matrix / 支援矩陣](SUPPORT_MATRIX.md)

---

## Overview

**Thorium Browser 151 (AVX-512 Edition)** is a custom high-performance Chromium fork built specifically for modern x86-64 processors supporting the **AVX-512 instruction set architecture** (Intel 10th/11th Gen Core, Xeon Scalable, and AMD Zen 4 / Zen 5).

By targeting `-march=skylake-avx512`, this release unlocks full 512-bit vector registers (`ZMM0`~`ZMM31`), hardware-level string parsing (`AVX-512BW`), vector byte manipulation (`AVX-512VBMI`), neural network instructions (`AVX-512_VNNI`), and zero-copy shared GPU rasterization.

In addition, this build features complete, battle-tested integration for **RIME (中州韻) / Fcitx5** input methods and **NVIDIA PRIME / VA-API** discrete GPU hardware video decoding.

---

## Key Features

1. **Pure AVX-512 Optimization**:
   * Compiled with Clang 19 and `-march=skylake-avx512 -O3 -flto=thin`.
   * V8 JavaScript JIT, WebAssembly, and Skia rendering pipeline are fully vectorized across 512-bit registers.
   * `AVX-512BW` accelerates DOM tokenization, UTF-8/UTF-16 encoding, and JSON parsing.
   * `AVX-512_VNNI` accelerates client-side WebNN / ONNX machine learning models.
2. **Seamless RIME / Fcitx5 Integration**:
   * Integrated D-Bus auto-discovery hook connecting client windows to active Fcitx5 daemon.
   * Eliminates candidate popup freezes and input focus drops on X11 and Wayland sessions.
3. **NVIDIA PRIME & Discrete GPU Acceleration**:
   * Pre-configured with automatic GPU offload flags (`__NV_PRIME_RENDER_OFFLOAD=1`, `__GLX_VENDOR_LIBRARY_NAME=nvidia`).
   * Zero-copy framebuffer sharing and hardware VA-API/NVDEC video decoding for 4K/8K 60fps AV1/HEVC streams.
4. **Host/Target Toolchain Segregation Architecture**:
   * Incorporates custom `clang_x64_target` toolchain separation patches, allowing AVX-512 binaries to be built on older AVX/AVX2 build hosts without generator tool crashes (`protoc`, `torque`, `cppgen`).

---

## Hardware Support Scope

Please refer to the full [SUPPORT_MATRIX.md](SUPPORT_MATRIX.md) for detailed hardware compatibility:

* **Supported (Intel)**: 11th Gen Core (Tiger Lake, Rocket Lake, e.g., i7-11800H), 10th Gen Core Mobile (Ice Lake), Core X-Series (Skylake-X, Cascade Lake-X), Xeon Scalable (1st~5th Gen), Xeon W Series.
* **Supported (AMD)**: Ryzen 7000 / 8000 / 9000 Series (Zen 4, Zen 5), EPYC 9004 / 8004 / 9005 Series, Ryzen Threadripper 7000 Series.
* **Not Supported**: Intel Broadwell/Haswell/Ivy Bridge (e.g. E5-2696 v4, i7-4770), AMD Zen 1~Zen 3 (Ryzen 1000~5000). *For these architectures, please use Thorium AVX2 or AVX builds.*

---

## Installation

Pre-built binaries are available in the [`packages/`](packages/) directory:

### Debian / Ubuntu / antiX
```bash
sudo apt install ./packages/thorium-browser_151.0.7922.72_AVX512_RIME.deb
```

### Arch Linux / Artix Linux / Manjaro
```bash
sudo pacman -U ./packages/thorium-browser-avx512-rime-bin-151.0.7922.72-1-x86_64.pkg.tar.zst
```

### Verification
Run `thorium-browser --version` to confirm installation:
```text
Chromium 154.0.8023.0
```

---

## Repository Structure

```text
.
├── config/
│   ├── args_avx512.gn       # Production AVX-512 GN build configuration
│   └── args_arm64.gn        # ARMv8 / Android Quest VR build configuration
├── packaging/
│   ├── arch/                # Arch Linux PKGBUILD and desktop launcher
│   └── deb/                 # Debian control scripts and metadata
├── patches/
│   ├── 0001-toolchain-segregation-avx512.patch
│   └── 0002-webui-color-change-listener-android-fix.patch
├── packages/
│   ├── SHA256SUMS           # Cryptographic checksums of release packages
│   ├── thorium-browser_151.0.7922.72_AVX512_RIME.deb
│   └── thorium-browser-avx512-rime-bin-151.0.7922.72-1-x86_64.pkg.tar.zst
├── scripts/
│   └── build_avx512.sh      # Automated build pipeline script
├── SUPPORT_MATRIX.md        # Detailed CPU and instruction set support matrix
├── README.md                # English documentation
└── README_zh.md             # Traditional Chinese documentation
```

---

## License

Thorium Browser source modifications and build scripts are released under the BSD-3-Clause License. Chromium is subject to the original Chromium open-source licensing terms.
