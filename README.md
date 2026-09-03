# Thorium Browser 152 (Chromium 152.0.7977.55 AVX-512 & RIME Edition)

[![Version](https://img.shields.io/badge/Version-M152.0.7977.55-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![Microarchitecture](https://img.shields.io/badge/Microarchitecture-IceLake%20%2F%20TigerLake%20%2F%20Zen4--5%20AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20Vectors-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-RIME%20%2F%20Fcitx5%20(Ozone%20Wayland)-orange.svg)](#2-rime--fcitx5-native-wayland-ime-deep-integration)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#3-widevine-cdm-protected-media-hardware-decryption)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [Hardware Support Matrix](SUPPORT_MATRIX.md)

---

## Overview

**Thorium Browser 152 (AVX-512 Edition)** is a customized high-performance Chromium build optimized for modern x86-64 processors supporting **AVX-512 vector instruction sets** (Intel 10th/11th Gen Core, Xeon Scalable, and AMD Zen 4 / Zen 5).

This release completes a full upgrade to the Chromium 152 baseline (`152.0.7977.55`), built with the latest LLVM/Clang 23.0.0git toolchain and C++23 standard. It unlocks 32x 512-bit wide `ZMM` vector registers, hardware string parsing (`AVX-512BW`), arbitrary byte shuffling (`AVX-512VBMI`), neural network acceleration (`AVX-512_VNNI`), and GPU zero-copy shared memory rasterization.

---

## 🚀 Key Build Improvements in M152

### 1. Upstream Upgrade & Modern Toolchain (Chromium 152 + Clang 23 + C++23)
- **Chromium 152 Core**: Upgraded from 151 to upstream stable baseline `152.0.7977.55`.
- **Clang 23.0 + C++23 Optimization**: Built with LLVM 23 `ld.lld` parallel ThinLTO (Link-Time Optimization).
- **V8 15.x Standard Features**: Permanently stabilized Float16Array, Explicit Resource Management (`using`), and RegExp escape.

### 2. Core Patches & SIMD Vector Microkernel Fixes
- **`0003-xnnpack-unary-elementwise-extra-x64.patch`**: Fixed `third_party/xnnpack/BUILD.gn` by adding the `unary_elementwise_extra_x64` source set for 6 AVX/F16C/BF16 elementwise microkernels.
- **`0004-libaom-highbd-variance-stat-avx2.patch`**: Fixed AV1 video decoder HighBitDepth symbol dependency in `third_party/libaom/.../variance.c` with weak fallback.

### 3. RIME / Fcitx5 Native Wayland IME Integration
- **Native Ozone Wayland IME Protocol**: Full support for `--ozone-platform=wayland` and `WAYLAND_IM_MODULE=fcitx5`, eliminating candidate box drift and focus loss in Wayland compositors (GNOME 46/47 Mutter, KDE Plasma 6 KWin).
- **Dynamic DBus & Xauthority Discovery**: Auto-detects active user session bus.

### 4. Widevine CDM Protected Streaming Decryption
- Built-in `libwidevinecdm.so` (Version 4.10.2830.0 / 4.10.3050.0) module registration.
- Full 1080p/4K DRM playback for Netflix, Spotify, Disney+, and Amazon Prime Video.

### 5. Native Google OAuth API Credentials & C++ AccountReconcilor Shield
- **Built-in Official Google API Keys**: Injected Google API Key and OAuth Client ID/Secret directly into the binary, restoring native Chrome Sync and Google account login flows.
- **`0005-account-reconcilor-cookie-shield.patch`**: Intercepts and blocks `AccountReconcilor::PerformLogoutAllAccountsAction` from evicting cookies from the Cookie Jar. Verified on hardware: **Google login sessions remain 100% persisted across browser restarts**!

### 6. Multi-Layer Process & Profile Sandbox Isolation
- Independent launcher (`/usr/local/bin/thorium-m152`), binary (`thorium-m152-bin`), user-data-dir (`~/.config/thorium-m152/`), disk cache, and Wayland `StartupWMClass=thorium-m152` with custom purple icon for zero collision with stock Thorium and Chromium.

---

## 📊 Benchmark Results (Intel Core i5-1035G1 Ice Lake AVX-512)

| Metric | Workload | Real-World Measurement |
| :--- | :--- | :--- |
| **V8 Engine Compute Throughput** | Float64 Matrix Mult (200x200) + Mandelbrot + 30k JSON | **`180.23 ms`** |
| **Cold Start Latency** | Headless Cold Launch to DOM Ready | **`1239.23 ms`** |
| **Wayland IME Latency** | fcitx5-rime candidate popup latency | **`< 2 ms` (Zero drift)** |

---

## Hardware Compatibility

* **✅ Supported (Intel)**: 10th Gen Core (Ice Lake), 11th Gen Core (Tiger Lake / Rocket Lake), Core X (Skylake-X / Cascade Lake-X), Xeon Scalable (Gen 1-5).
* **✅ Supported (AMD)**: Ryzen 7000 / 8000 / 9000 (Zen 4, Zen 5), EPYC 9004 / 8004 / 9005.
* **❌ Unsupported**: Broadwell, Haswell, Ivy Bridge (e.g. E5-2696 v4), AMD Zen 1-3.

---

## License

BSD-3-Clause License. Chromium is subject to the Chromium authors' license.
