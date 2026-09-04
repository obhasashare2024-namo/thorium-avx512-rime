# Thorium ブラウザ 154（Chromium 154.0.8023.0 + Thorium 152 ハイブリッド AVX-512 & RIME 日本語・中国語対応旗艦版）

[![Version](https://img.shields.io/badge/Version-M154.0.8023.0--AVX512-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![Microarchitecture](https://img.shields.io/badge/CPU-IceLake%20%2F%20TigerLake%20%2F%20Zen4--5%20AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20Vectors-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-Fcitx5%20%2F%20RIME%20(Ozone%20Wayland)-orange.svg)](#wayland-ime)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#widevine-cdm)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [ハードウェア対応表](SUPPORT_MATRIX.md)

---

## 概要

**Thorium Browser 154 (AVX-512 Edition)** は、最新の **Chromium 154 コア (`154.0.8023.0`)** と **Thorium 152 の高性能 AVX-512 ベクトルマイクロカーネル・マルチメディアコーデック** を融合したハイブリッド版 Chromium です。

Intel 第 10/11 世代 Core、Xeon Scalable、AMD Zen 4 / Zen 5 などの **AVX-512 ベクトル命令セット** を完全活用し、LLVM/Clang 23.0.0git + C++23 ThinLTO 最適化によってビルドされています。

---

## 🚀 M154 ハイブリッドビルドの主な改善点

1. **Chromium 154 コア + Thorium 152 SIMD ベクトルの融合**
2. **LLVM 23 + C++23 ThinLTO 最適化コンパイル（バイナリ 338 MB）**
3. **10 大コア箇所における完全デカップリング（`thorium` 命名への統一、PID 競合・単例ロック競合の完全根絶）**
4. **公式 Google OAuth API 認証情報の組み込み & Chromium 154 対応 C++ クッキー保護シールド（ブラウザ再起動後もログイン維持）**
5. **Wayland Ozone ネイティブ IME 対応（`WAYLAND_IM_MODULE=fcitx5` による候補ウィンドウのズレ解消）**
6. **Widevine DRM CDM ネイティブ統合（Netflix / Spotify 4K/1080p 再生）**
7. **DBSC ビルドフラグガード、Crubit Rust-C++ 相互運用修正パッチの適用**

---

## ライセンス

BSD-3-Clause License。Chromium ソースコードは元のライセンスに準拠します。
