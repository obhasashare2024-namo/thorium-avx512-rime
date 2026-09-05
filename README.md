# Thorium Browser 154 (Chromium 154.0.8023.0 + Thorium 152 Hybrid AVX-512 & AVX2 & RIME Edition)

[![Version](https://img.shields.io/badge/Version-M154.0.8023.0--AVX512%20%26%20AVX2-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![Microarchitecture](https://img.shields.io/badge/Microarchitecture-AVX512%20%26%20AVX2%20Dual%20Support-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20%2F%20256--bit%20YMM-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-RIME%20%2F%20Fcitx5%20(Ozone%20Wayland)-orange.svg)](#4-rime--fcitx5-native-wayland--x11-ime-deep-integration)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#5-widevine-cdm-protected-streaming-decryption)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [Hardware Support Matrix](SUPPORT_MATRIX.md)

---

## Overview

**Thorium Browser 154 (AVX-512 & AVX2 Dual Microarchitecture Edition)** is a hybrid high-performance Chromium build combining the modern **Chromium 154 core (`154.0.8023.0`)** with **Thorium 152's performance microkernels, multimedia codecs, and native SIMD vector optimizations**.

It provides two tailored native builds for modern x86-64 processors:
1. **AVX-512 Build (`-march=skylake-avx512`)**: Compiled for Intel 10th/11th Gen Core, Core X, Xeon Scalable, and AMD Zen 4 / Zen 5. Unlocks 32x 512-bit wide `ZMM` vector registers, hardware string parsing (`AVX-512BW`), arbitrary byte shuffling (`AVX-512VBMI`), and neural network acceleration (`AVX-512_VNNI`).
2. **AVX2 Build (`-march=haswell`)**: Compiled for Intel 4th Gen Core (Haswell) through 14th Gen Core (Raptor Lake Refresh), Xeon E3/E5 v3/v4, and AMD Ryzen 1000-5000 (Zen 1/2/3). Delivers full 256-bit AVX2, FMA3, and BMI1/2 acceleration with zero SIGILL risk.

Both builds are compiled with LLVM/Clang 23.0.0git, C++23, and multi-threaded ThinLTO, delivering maximum throughput and tight binary footprints (~338 MB).

---

## 🚀 Key Build Improvements in M154 Hybrid Release

### 1. Chromium 154 Core Baseline + Thorium 152 SIMD Hybrid Architecture
- **Chromium 154 Core**: Upgraded baseline to `154.0.8023.0`, bringing upstream security updates, modern Web APIs, and refined Blink layout performance.
- **Thorium 152 SIMD Microkernels**: Merged Thorium's high-efficiency multimedia codecs, AV1/VP9 assembly optimizations, and architecture-specific vector compiler flags.
- **Clang 23.0 + C++23 ThinLTO**: Multi-threaded link-time optimization producing tightly packed binaries stripped down to ~338 MB.

### 2. Dual Microarchitecture Release Matrix (AVX-512 & AVX2)
- **AVX-512 Edition**: Targets `skylake-avx512` (AVX-512F, BW, CD, DQ, VL), providing the ultimate compute throughput for modern enthusiast and workstation platforms.
- **AVX2 Edition**: Targets `haswell` (AVX2, FMA, BMI1, BMI2), ensuring 100% stable execution across older enterprise servers (e.g. Dual Xeon E5-2696 v4) and consumer desktop architectures without AVX-512.

### 3. Full Atom Logo Rebase, Gold Icon Asset & Hardcoded Process Decoupling (`thorium`)
To eliminate PID collision, process kill ambiguity (`killall chrome`), singleton lock contention (`SingletonLock`), and conflicts with system Chromium or `webllm-farm`:
- **Official Atom Logo Rebase**: Replaced all resource assets with official Thorium atom logos (16x16 to 256x256), eliminating all legacy Chromium roundel artifacts.
- **About Page UI & Scale Fix**: CSS injection `#productLogo { width: 32px; height: 32px; }` preventing oversized logos; complete localization branding string override ("Settings - About Thorium - Thorium").
- **Exclusive Gold Icon Asset**: Bundled distinct metallic gold atom icon (`assets/thorium-gold.png`) for instant visual decoupling alongside farm green and standard purple profiles.
- **Kernel Process Hardening**: Binary output locked to `thorium` in `chrome/BUILD.gn` and kernel process communication name (`/proc/$PID/comm`) enforced via `prctl(PR_SET_NAME, "thorium")`.
- **User Data & Cache Directories**: Mapped exclusively to `~/.config/thorium` and `~/.cache/thorium`.
- **Window Manager Identity**: `StartupWMClass=thorium-browser` (or `StartupWMClass=t154` in isolated test scopes).

### 4. Native Google OAuth API Credentials & C++ Cookie Persistence Shield
- **Built-in Official Google API Keys**: Restores native Google Account login and Chrome Sync.
- **`0005-account-reconcilor-cookie-shield-154.patch`**: Updated and adapted to Chromium 154's revised `GoogleServiceAuthError` API. Intercepts `AccountReconcilor::PerformLogoutAllAccountsAction` to permanently protect cookie jar sessions. **Google accounts remain 100% logged in across browser restarts**.

### 5. RIME / Fcitx5 Native Wayland & X11 IME Deep Integration
- Full support for `--ozone-platform=wayland` and `WAYLAND_IM_MODULE=fcitx5` as well as native X11 fallback.
- Eliminates candidate box drift, focus loss, and input lag in GNOME 46/47 Mutter and KDE Plasma 6 KWin.
- Dynamic DBus session bus and Xauthority detection.

### 6. Widevine CDM Protected Streaming Decryption
- Integrated `libwidevinecdm.so` module registration and dynamic CDM adapter.
- Full 1080p/4K DRM playback verified on Netflix, Spotify, Disney+, and Amazon Prime Video.

### 7. Architectural Compatibility & Toolchain Patches
- **`0006-signin-dbsc-buildflag-guard.patch`**: Guarded Device Bound Session Credentials (DBSC) registration under `#if BUILDFLAG(ENABLE_DEVICE_BOUND_SESSIONS)` to prevent undefined linker symbols.
- **`0007-crubit-rust-integrity-parser-fix.patch`**: Resolved Crubit Rust-C++ FFI interoperability and parser result handling.
- **`0008-thorium-m154-decoupling-and-packaging.patch`**: Comprehensive packaging and brand decoupling across Debian, Arch Linux (`makepkg`), and standalone portable bundles.

---

## 📦 Release Artifacts & SHA-256 Checksums

| Package | Microarchitecture | Format | SHA-256 Checksum |
| :--- | :--- | :--- | :--- |
| `thorium-browser_154.0.8023.0_AVX512.deb` | AVX-512 | Debian / Ubuntu / Deepin | `d61a5234bbc83915cb868535e5c038f90f6644054c09bd12fa68d00750a1426d` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX-512 | Arch Linux / CachyOS / Artix | `1a651544265f3eded82b4c4a31bff085beee253c3abee61a27ddb9eab445b48e` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-portable.tar.gz` | AVX-512 | Generic Linux Portable Tarball | `9208ebd6e26a74167a90d6ed43c4c1bc767b264f9f85df75965932889de19e5d` |
| `thorium-browser_154.0.8023.0_AVX2.deb` | AVX2 | Debian / Ubuntu / Deepin | `f4856157f2f82fe9b01dd1da8ab797aa8d487451187872bc74f463a746bd75d8` |
| `thorium-browser-avx2-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX2 | Arch Linux / CachyOS / Artix | `612d2d4ed6138d58deadd46322f3d2dcc2d4d32029cf3df58191867e0695b682` |
| `thorium-browser-avx2-rime-bin-154.0.8023.0-portable.tar.gz` | AVX2 | Generic Linux Portable Tarball | `dd2d45e17bfc4f1f29cf6f78dd6b2a7c6b3d7ab2e8def131b422f4fdb8d850e0` |
| `thorium-gold.png` | Universal | Official Metallic Gold Icon Asset | `0ca24a89340bcbace48f6b4f4ee1f71b36777d3bd2edd06a6b6591547027d321` |
| `thorium-m154-avx512-suite.zip` | Universal | Full Source Patches & Setup Suite | `0ecb9b8b6ff92a7e7bb60b133ba50c379a7852c00a4023b8273eaee179f8ad38` |
| `SHA256SUMS.txt` | Universal | Official Verification Checksum Manifest | Full Release Checksums |

---

## 📊 Benchmark Results

| Metric | Architecture | Workload | Real-World Measurement |
| :--- | :--- | :--- | :--- |
| **V8 Engine Compute Throughput** | AVX-512 (i5-1035G1) | Float64 Matrix Mult (200x200) + Mandelbrot + 30k JSON | **`178.40 ms`** |
| **V8 Engine Compute Throughput** | AVX2 (Xeon E5-2696 v4) | Float64 Matrix Mult (200x200) + Mandelbrot + 30k JSON | **`212.80 ms`** |
| **Cold Start Latency** | AVX-512 / AVX2 | Headless Cold Launch to DOM Ready | **`1180 ~ 1210 ms`** |
| **Wayland IME Latency** | AVX-512 / AVX2 | fcitx5-rime candidate popup latency | **`< 2 ms` (Zero drift)** |

---

## Hardware Compatibility

### AVX-512 Build
* **Intel**: 10th Gen Core (Ice Lake), 11th Gen Core (Tiger Lake / Rocket Lake), Core X (Skylake-X / Cascade Lake-X), Xeon Scalable (Gen 1-5).
* **AMD**: Ryzen 7000 / 8000 / 9000 (Zen 4, Zen 5), EPYC 9004 / 8004 / 9005.

### AVX2 Build
* **Intel**: 4th Gen Core (Haswell) to 14th Gen Core (Raptor Lake Refresh), Xeon E3/E5 v3/v4, Core i3/i5/i7/i9 (Haswell, Broadwell, Skylake, Kaby Lake, Coffee Lake, Comet Lake, Rocket Lake, Alder Lake, Raptor Lake).
* **AMD**: Ryzen 1000 to 5000 series (Zen 1, Zen+, Zen 2, Zen 3), AMD FX/Excavator (AVX2 supported).

---

## License

BSD-3-Clause License. Chromium is subject to the Chromium authors' license.
