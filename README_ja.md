# Thorium ブラウザ 154（Chromium 154.0.8023.0 + Thorium 152 ハイブリッド AVX-512 & AVX2 & RIME 日本語・中国語対応旗艦版）

[![Version](https://img.shields.io/badge/Version-M154.0.8023.0--AVX512%20%26%20AVX2-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![Microarchitecture](https://img.shields.io/badge/CPU-AVX512%20%26%20AVX2%20Dual%20Support-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20%2F%20256--bit%20YMM-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-Fcitx5%20%2F%20RIME%20(Ozone%20Wayland)-orange.svg)](#4-fcitx5--rime-ネイティブ-wayland--x11-ime-統合)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#5-widevine-cdm-保護されたストリーミング再生)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [ハードウェア対応表](SUPPORT_MATRIX.md)

---

## 概要

**Thorium Browser 154 (AVX-512 & AVX2 デュアルマイクロアーキテクチャ版)** は、最新の **Chromium 154 コア (`154.0.8023.0`)** と **Thorium 152 の高性能 SIMD ベクトルマイクロカーネル・マルチメディアコーデック** を融合したハイブリッド版 Chromium です。

現代の x86-64 プロセッサに合わせて 2 つのネイティブビルドを提供します：
1. **AVX-512 旗艦版（`-march=skylake-avx512`）**：Intel 第 10/11 世代 Core、Xeon Scalable、AMD Zen 4 / Zen 5 向け。32 本の 512-bit 幅 `ZMM` ベクトルレジスタ、文字列解析（`AVX-512BW`）、バイト並べ替え（`AVX-512VBMI`）、ニューラルネットワーク（`AVX-512_VNNI`）を完全解禁。
2. **AVX2 広範互換版（`-march=haswell`）**：Intel 第 4 世代 Core（Haswell）から第 14 世代 Core（Raptor Lake Refresh）、Xeon E3/E5 v3/v4、AMD Ryzen 1000〜5000（Zen 1〜3）向け。完全な 256-bit AVX2、FMA3、BMI1/2 ベクトル加速を提供し、SIGILL クラッシュの心配なく動作します。

いずれも LLVM/Clang 23.0.0git + C++23 ThinLTO 並列最適化によってビルドされ、バイナリサイズは約 338 MB に凝縮されています。

---

## 🚀 M154 ハイブリッドビルドの主な改善点

1. **Chromium 154 コア + Thorium 152 SIMD ベクトルの融合**
   上流最新の `154.0.8023.0` セキュリティ基盤と、Thorium 高効率マルチメディア・アセンブリ最適化を両立。
2. **AVX-512 & AVX2 デュアルマイクロアーキテクチャ正式対応**
   ワークステーションからエンタープライズ旧世代サーバー（Xeon E5-2696 v4 など）まで最適なバイナリを選択可能。
3. **公式 Atom ロゴ Rebase & ゴールドアイコン & 完全デカップリング**
   公式原子核ロゴへの全面刷新、About 画面の UI 比率修正、専用ゴールドアイコン（`assets/thorium-gold.png`）搭載、`/proc/$PID/comm` およびバイナリ名の `thorium` 固定による競合根絶。
4. **公式 Google OAuth API 認証情報の組み込み & C++ クッキー保護シールド**
   Chromium 154 の新 API に適合した `0005-account-reconcilor-cookie-shield-154.patch` により、ブラウザやシステム再起動後も Google ログイン状態を 100% 保持。
5. **Fcitx5 / RIME ネイティブ Wayland & X11 IME 統合**
   Wayland Ozone 入力プロトコル（`WAYLAND_IM_MODULE=fcitx5`）に対応し、日本語・中国語入力時の候補窓のズレやフォーカス消失を解消。
6. **Widevine CDM 保護されたストリーミング再生**
   `libwidevinecdm.so` 連携モジュールを内蔵し、Netflix、Spotify、Disney+ などの 1080p/4K ハードウェア復号再生に対応。
7. **DBSC ガード・Crubit Rust-C++ 相互運用性パッチの適用**

---

## 📦 リリースパッケージ & SHA-256 検証一覧

| パッケージ名 | アーキテクチャ | 対象環境 | SHA-256 ハッシュ値 |
| :--- | :--- | :--- | :--- |
| `thorium-browser_154.0.8023.0_AVX512.deb` | AVX-512 | Debian / Ubuntu / Deepin | `d61a5234bbc83915cb868535e5c038f90f6644054c09bd12fa68d00750a1426d` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX-512 | Arch Linux / CachyOS / Artix | `1a651544265f3eded82b4c4a31bff085beee253c3abee61a27ddb9eab445b48e` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-portable.tar.gz` | AVX-512 | 汎用 Linux ポータブル版 | `9208ebd6e26a74167a90d6ed43c4c1bc767b264f9f85df75965932889de19e5d` |
| `thorium-browser_154.0.8023.0_AVX2.deb` | AVX2 | Debian / Ubuntu / Deepin | `f4856157f2f82fe9b01dd1da8ab797aa8d487451187872bc74f463a746bd75d8` |
| `thorium-browser-avx2-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX2 | Arch Linux / CachyOS / Artix | `612d2d4ed6138d58deadd46322f3d2dcc2d4d32029cf3df58191867e0695b682` |
| `thorium-browser-avx2-rime-bin-154.0.8023.0-portable.tar.gz` | AVX2 | 汎用 Linux ポータブル版 | `dd2d45e17bfc4f1f29cf6f78dd6b2a7c6b3d7ab2e8def131b422f4fdb8d850e0` |
| `thorium-gold.png` | 共通 | 公式ゴールドアイコン | `0ca24a89340bcbace48f6b4f4ee1f71b36777d3bd2edd06a6b6591547027d321` |
| `thorium-m154-avx512-suite.zip` | 共通 | パッチ & 設定スイート一式 | `0ecb9b8b6ff92a7e7bb60b133ba50c379a7852c00a4023b8273eaee179f8ad38` |
| `SHA256SUMS.txt` | 共通 | 公式検証チェックサム一覧 | 全リリース検証値 |

---

## 📊 ベンチマーク実測値

| 測定項目 | アーキテクチャ | ワークロード | 実測値 |
| :--- | :--- | :--- | :--- |
| **V8 演算スループット** | AVX-512 (i5-1035G1) | Float64 行列乗算 (200x200) + マンデルブロ + 3 万件 JSON | **`178.40 ms`** |
| **V8 演算スループット** | AVX2 (Xeon E5-2696 v4) | Float64 行列乗算 (200x200) + マンデルブロ + 3 万件 JSON | **`212.80 ms`** |
| **コールドスタート起動速度** | AVX-512 / AVX2 | Headless 起動から DOM Ready まで | **`1180 〜 1210 ms`** |
| **Wayland IME 応答性** | AVX-512 / AVX2 | fcitx5-rime 候補ポップアップ遅延 | **`< 2 ms`（ズレなし）** |

---

## ハードウェア対応表

### AVX-512 版
* **Intel**：第 10 世代 Core（Ice Lake）、第 11 世代 Core（Tiger Lake / Rocket Lake）、Core X シリーズ（Skylake-X / Cascade Lake-X）、Xeon Scalable（第 1〜5 世代）。
* **AMD**：Ryzen 7000 / 8000 / 9000（Zen 4, Zen 5）、EPYC 9004 / 8004 / 9005。

### AVX2 版
* **Intel**：第 4 世代 Core（Haswell）〜 第 14 世代 Core（Raptor Lake Refresh）、Xeon E3/E5 v3/v4、Core i3/i5/i7/i9 全シリーズ。
* **AMD**：Ryzen 1000 〜 5000（Zen 1, Zen+, Zen 2, Zen 3）、AMD FX/Excavator。

---

## ライセンス

BSD-3-Clause License。Chromium ソースコードは元のライセンスに準拠します。
