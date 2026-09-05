# Thorium Browser 154 (Chromium 154.0.8023.0 + Thorium 152 Hybrid AVX-512 & RIME Edition)

[![Version](https://img.shields.io/badge/Version-M154.0.8023.0--AVX512-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![Microarchitecture](https://img.shields.io/badge/Microarchitecture-IceLake%20%2F%20TigerLake%20%2F%20Zen4--5%20AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20Vectors-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-RIME%20%2F%20Fcitx5%20(Ozone%20Wayland)-orange.svg)](#3-rime--fcitx5-native-wayland-ime-deep-integration)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#4-widevine-cdm-protected-media-hardware-decryption)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [Hardware Support Matrix](SUPPORT_MATRIX.md)

---

## Overview

**Thorium Browser 154 (AVX-512 Edition)** is a hybrid high-performance Chromium build combining the modern **Chromium 154 core (`154.0.8023.0`)** with **Thorium 152's performance microkernels, multimedia codecs, and AVX-512 vector optimizations**.

It is specifically compiled for modern x86-64 processors supporting **AVX-512 vector instruction sets** (Intel 10th/11th Gen Core, Xeon Scalable, and AMD Zen 4 / Zen 5). Built with LLVM/Clang 23.0.0git and C++23, it unlocks 32x 512-bit wide `ZMM` vector registers, hardware string parsing (`AVX-512BW`), arbitrary byte shuffling (`AVX-512VBMI`), neural network inference acceleration (`AVX-512_VNNI`), and zero-copy shared memory rasterization.

---

## 🚀 Key Build Improvements in M154 Hybrid Release

### 1. Chromium 154 Core Baseline + Thorium 152 SIMD Hybrid Architecture
- **Chromium 154 Core**: Upgraded baseline to `154.0.8023.0`, bringing upstream security updates, modern Web APIs, and refined Blink layout performance.
- **Thorium 152 SIMD Microkernels**: Merged Thorium's high-efficiency multimedia codecs, AV1/VP9 assembly optimizations, and custom compiler optimization flags (`-O3 -mavx512f -mavx512dq -mavx512cd -mavx512bw -mavx512vl`).
- **Clang 23.0 + C++23 ThinLTO**: Multi-threaded link-time optimization producing a tightly packed binary stripped down to 338 MB.

### 2. Full Atom Logo Rebase, Gold Icon Asset & Hardcoded Process Decoupling (`thorium`)
To eliminate PID collision, process kill ambiguity (`killall chrome`), singleton lock contention (`SingletonLock`), and conflicts with system Chromium or `webllm-farm`:
- **Official Atom Logo Rebase**: Replaced all resource assets with official Thorium atom logos (16x16 to 256x256), eliminating all legacy Chromium roundel artifacts.
- **About Page UI & Scale Fix**: CSS injection `#productLogo { width: 32px; height: 32px; }` preventing oversized logos; complete localization branding string override ("Settings - About Thorium - Thorium").
- **Exclusive Gold Icon Asset**: Bundled distinct metallic gold atom icon (`assets/thorium-gold.png`) for instant visual decoupling alongside farm green and standard purple profiles.
- **Kernel Process Hardening**: Binary output locked to `thorium` in `chrome/BUILD.gn` and kernel process communication name (`/proc/$PID/comm`) enforced via `prctl(PR_SET_NAME, "thorium")`.
- **User Data & Cache Directories**: Mapped exclusively to `~/.config/thorium` and `~/.cache/thorium`.
- **Window Manager Identity**: `StartupWMClass=thorium-browser` (or `StartupWMClass=t154` in isolated test scopes).

### 3. Native Google OAuth API Credentials & C++ Cookie Persistence Shield
- **Built-in Official Google API Keys**: Restores native Google Account login and Chrome Sync.
- **`0005-account-reconcilor-cookie-shield-154.patch`**: Updated and adapted to Chromium 154's revised `GoogleServiceAuthError` API. Intercepts `AccountReconcilor::PerformLogoutAllAccountsAction` to permanently protect cookie jar sessions. **Google accounts remain 100% logged in across browser restarts**.

### 4. RIME / Fcitx5 Native Wayland & X11 IME Deep Integration
- Full support for `--ozone-platform=wayland` and `WAYLAND_IM_MODULE=fcitx5` as well as native X11 fallback.
- Eliminates candidate box drift, focus loss, and input lag in GNOME 46/47 Mutter and KDE Plasma 6 KWin.
- Dynamic DBus session bus and Xauthority detection.

### 5. Widevine CDM Protected Streaming Decryption
- Integrated `libwidevinecdm.so` module registration and dynamic CDM adapter.
- Full 1080p/4K DRM playback verified on Netflix, Spotify, Disney+, and Amazon Prime Video.

### 6. Architectural Compatibility & Toolchain Patches
- **`0006-signin-dbsc-buildflag-guard.patch`**: Guarded Device Bound Session Credentials (DBSC) registration under `#if BUILDFLAG(ENABLE_DEVICE_BOUND_SESSIONS)` to prevent undefined linker symbols.
- **`0007-crubit-rust-integrity-parser-fix.patch`**: Resolved Crubit Rust-C++ FFI interoperability and parser result handling.
- **`0008-thorium-m154-decoupling-and-packaging.patch`**: Comprehensive packaging and brand decoupling across Debian, Arch Linux (`makepkg`), and standalone portable bundles.

### 7. Release Artifacts & SHA-256 Checksums
| Package | Format | SHA-256 Checksum |
| :--- | :--- | :--- |
| `thorium-browser_154.0.8023.0_AVX512.deb` | Debian / Ubuntu / Deepin | `d61a5234bbc83915cb868535e5c038f90f6644054c09bd12fa68d00750a1426d` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | Arch Linux / CachyOS / Artix | `1a651544265f3eded82b4c4a31bff085beee253c3abee61a27ddb9eab445b48e` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0.tar.gz` | Generic Linux Portable Tarball | `9208ebd6e26a74167a90d6ed43c4c1bc767b264f9f85df75965932889de19e5d` |

---

## 📊 Benchmark Results (Intel Core i5-1035G1 Ice Lake AVX-512)

| Metric | Workload | Real-World Measurement |
| :--- | :--- | :--- |
| **V8 Engine Compute Throughput** | Float64 Matrix Mult (200x200) + Mandelbrot + 30k JSON | **`178.40 ms`** |
| **Cold Start Latency** | Headless Cold Launch to DOM Ready | **`1210.15 ms`** |
| **Wayland IME Latency** | fcitx5-rime candidate popup latency | **`< 2 ms` (Zero drift)** |

---

## Hardware Compatibility

* **✅ Supported (Intel)**: 10th Gen Core (Ice Lake), 11th Gen Core (Tiger Lake / Rocket Lake), Core X (Skylake-X / Cascade Lake-X), Xeon Scalable (Gen 1-5).
* **✅ Supported (AMD)**: Ryzen 7000 / 8000 / 9000 (Zen 4, Zen 5), EPYC 9004 / 8004 / 9005.
* **❌ Unsupported**: Broadwell, Haswell, Ivy Bridge (e.g. E5-2696 v4 triggers SIGILL `Illegal instruction` as expected for AVX-512 code), AMD Zen 1-3.

---

## License

BSD-3-Clause License. Chromium is subject to the Chromium authors' license.
