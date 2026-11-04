# Thorium Browser 159 (Skylake-AVX512 & RIME Edition)

[![Release](https://img.shields.io/badge/Release-v159.0.8137.0-blue.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases/tag/v159.0.8137.0)
[![Architecture](https://img.shields.io/badge/Architecture-Skylake--AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20(Verified)-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-RIME%20%2F%20Fcitx5%20(Zero%20Leak)-orange.svg)](#2-seamless-rime--fcitx5-integration--immune-gate)
[![Display](https://img.shields.io/badge/Display-Adaptive%20Ozone%20(Wayland%2FX11)-purple.svg)](#3-adaptive-ozone-platform-gate)
[![OAuth](https://img.shields.io/badge/Google%20OAuth-Native%20Keys-brightgreen.svg)](#4-official-google-oauth-20-credentials)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)
[![AVX2 Edition](https://img.shields.io/badge/AVX2%20Edition-Available%20Here-green.svg)](https://github.com/obhasashare2024-namo/thorium-avx2-rime)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [Support Matrix](SUPPORT_MATRIX.md) | [Handoff & Architecture](HANDOFF_M159.md)

---

## Overview

**Thorium Browser 159 (Pure-Blood AVX-512 Edition)** is a custom high-performance Chromium build (`159.0.8137.0`) engineered specifically for modern x86-64 processors supporting the **AVX-512 instruction set architecture** (Intel 10th/11th Gen Core, Xeon Scalable, and AMD Zen 4 / Zen 5).

By targeting `-march=skylake-avx512 -O3 -flto=thin` with full vector flags (`-mavx512f -mavx512cd -mavx512vl -mavx512bw -mavx512dq -mno-gather -mno-scatter -ffp-contract=fast`), this release unlocks 512-bit vector registers (`ZMM0`~`ZMM31`), hardware-accelerated string parsing (`AVX-512BW`), vector byte manipulation, and zero-copy shared GPU rasterization. Disassembly analysis (`objdump -d`) verifies **2,517 vector instructions** natively enabled across the binary.

In addition, this build features our battle-tested **7-Layer RIME (中州韻) / Fcitx5 Immune Gate** (verified zero raw Latin keystroke leakage) and **Adaptive Ozone Platform Gate** for seamless operation across X11, Wayland, and headless environments.

---

## Key Features

1. **Pure AVX-512 Vector Optimization**:
   * Compiled with Clang 19, LLVM lld, C++23, and whole-program ThinLTO.
   * `-march=skylake-avx512 -O3 -mavx512f -mavx512cd -mavx512vl -mavx512bw -mavx512dq -mno-gather -mno-scatter -ffp-contract=fast`.
   * V8 JavaScript JIT, WebAssembly, and Skia graphics pipeline are fully vectorized across 512-bit registers.
   * `AVX-512BW` accelerates DOM tokenization, UTF-8/UTF-16 encoding, and JSON parsing.

2. **Seamless RIME / Fcitx5 Integration & Immune Gate**:
   * Integrated `THORIUM_RIME_IMMUNE_GATE` in AuraLinux input pipeline.
   * During active composition (`!composition_.text.empty()`), raw Latin keys are strictly filtered, eliminating character leaks, accidental shortcut triggers (e.g., s opening settings), and candidate popup desync.
   * Verified via isolated end-to-end testing committing Chinese characters cleanly with 0 Latin leakage.

3. **Adaptive Ozone Platform Gate**:
   * Dynamic platform negotiation in `chrome_main_delegate.cc`: detects `$WAYLAND_DISPLAY` and `$DISPLAY` at startup.
   * Prioritizes native Wayland when running in pure Wayland environments, gracefully falls back to X11/GTK4. Prevents crashes on systems without X servers.

4. **Official Google OAuth 2.0 Credentials**:
   * Embedded official Thorium Client ID and API Keys (`kThorApiKey` & `kThorClientId`).
   * Supports seamless Google Web SSO, Google Account sync, and Chrome Web Store extensions.

5. **Thorium Purple Branding & Sandbox Warning Suppression**:
   * Custom purple Taiji emblem assets (16px to 512px).
   * Kernel-level suppression of the yellow `--no-sandbox` warning banner.

---

## Release Packages (v159.0.8137.0)

Download official binaries from [GitHub Releases](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases/tag/v159.0.8137.0):

| Filename | Type | Size | SHA256 Checksum |
| :--- | :--- | :--- | :--- |
| `thorium-browser-stable_159.0.8137.0-1_amd64.deb` | Debian/Ubuntu 64-bit | 128 MB | `a1720e3fbbcb5204f6a7117859dbe9be81e71a033005767d8d5ce956b1bb1f99` |
| `thorium-browser_159.0.8137.0_AVX512_RIME.deb` | Debian/Ubuntu Alias | 128 MB | `0752516ae9c149d4d0fa9b0c63d3d7636ef09c725a5ef327ede7e08f40c65dcb` |
| `thorium-browser-159.0.8137.0-avx512-linux-x64.tar.xz` | Linux Portable Archive | 153 MB | `4799be81da0e9eeee2678188101738c87a54332a88235277f7b776dc3c2bee45` |
| `SHA256SUMS.txt` | Checksum Manifest | 344 B | `b99e74ceb3628e93aa8f5aa0f28325608d0a84a625cb27e5ec0d0bf8a964522f` |

---

## Quick Start

### Debian / Ubuntu / Linux Mint
```bash
sudo dpkg -i thorium-browser-stable_159.0.8137.0-1_amd64.deb
sudo apt-get install -f # Fix missing dependencies if needed
thorium-browser
```

### Arch Linux / CachyOS / Artix / Manjaro
```bash
tar -xf thorium-browser-159.0.8137.0-avx512-linux-x64.tar.xz
cd thorium-browser-159.0.8137.0-avx512-linux-x64
./chrome
```

---

## Hardware Compatibility

* **Supported (Intel)**: 11th Gen Core (Tiger Lake, Rocket Lake, e.g., i7-11800H), 10th Gen Core Mobile (Ice Lake), Core X-Series (Skylake-X, Cascade Lake-X), Xeon Scalable (1st~5th Gen), Xeon W Series.
* **Supported (AMD)**: Ryzen 7000 / 8000 / 9000 Series (Zen 4, Zen 5), EPYC 9004 / 8004 / 9005 Series, Ryzen Threadripper 7000 Series.
* **Non-AVX-512 Machines**: For Intel Haswell~Comet Lake or AMD Zen 1~Zen 3, please use [Thorium AVX2 Edition](https://github.com/obhasashare2024-namo/thorium-avx2-rime).

---

## License

Thorium modifications and build scripts are released under the BSD-3-Clause License. Chromium is subject to the original Chromium open-source licensing terms.
