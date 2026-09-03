# Thorium ブラウザ 152（Chromium 152.0.7977.55 AVX-512 & RIME 日本語・中国語対応旗艦版）

[![Version](https://img.shields.io/badge/Version-M152.0.7977.55-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![Microarchitecture](https://img.shields.io/badge/CPU-IceLake%20%2F%20TigerLake%20%2F%20Zen4--5%20AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20Vectors-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-Fcitx5%20%2F%20RIME%20(Ozone%20Wayland)-orange.svg)](#wayland-ime)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#widevine-cdm)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [ハードウェア対応表](SUPPORT_MATRIX.md)

---

## 概要

**Thorium Browser 152 (AVX-512 Edition)** は、最新の **AVX-512 ベクトル命令セット** を備えた x86-64 プロセッサ（Intel 第 10/11 世代 Core、Xeon Scalable、AMD Zen 4 / Zen 5）向けに最適化された超高速 Chromium 152 分岐版です。

LLVM/Clang 23.0.0git + C++23 標準を採用し、32 個の 512 ビット `ZMM` レジスタ、ハードウェア文字列解析（`AVX-512BW`）、ニューラルネットワーク推論アクセラレーション（`AVX-512_VNNI`）を完全活用します。

---

## 🚀 M152 ビルドの主な改善点

1. **Chromium 152 カーネルへの完全アップグレード (`152.0.7977.55`)**
2. **LLVM 23 + C++23 ThinLTO 最適化コンパイル**
3. **XNNPACK & libaom AV1 内部 SIMD ベクトルパッチの適用 (`0003` & `0004` patch)**
4. **Wayland Ozone ネイティブ IME 対応 (`WAYLAND_IM_MODULE=fcitx5` による候補ウィンドウのズレ解消)**
5. **Widevine DRM CDM (`4.10.3050.0`) ネイティブ統合（Netflix / Spotify 4K/1080p 再生）**
6. **公式 Google OAuth API 認証情報の組み込み & C++ クッキー保護シールド (`0005` patch - 再起動後もログイン維持)**
7. **独立サンドボックス構造（マルチレイヤー物理分離・旧バージョンとの完全並行実行対応）**

---

## ライセンス

BSD-3-Clause License。Chromium ソースコードは元のライセンスに準拠します。
