<p align="center">
  <img src="assets/thorium-purple-lightning.png" width="220" alt="Thorium Browser Emblem">
</p>

# Thorium Browser 154（Chromium 154.0.8023.0 + Thorium 152 ハイブリッド AVX-512 旗艦版）- RIME IME統合＆ハードウェア動画デコード

[![リリース](https://img.shields.io/badge/リリース-v154.0.8023.0-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases/tag/v154.0.8023.0)
[![アーキテクチャ](https://img.shields.io/badge/アーキテクチャ-AVX--512%20(Skylake--X%20%2F%20Zen4)-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-RIME%20%2F%20Fcitx5%20(Ozone%20Wayland)-orange.svg)](#4-rime--fcitx5-ネイティブ-wayland--x11-ime-統合)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#5-widevine-cdm-保護ストリーミング再生)
[![ライセンス](https://img.shields.io/badge/ライセンス-BSD--3--Clause-lightgrey.svg)](LICENSE)
[![AVX2 專用版](https://img.shields.io/badge/AVX2%20専用版-こちらへ-orange.svg)](https://github.com/obhasashare2024-namo/thorium-avx2-rime)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [ハードウェア互換性表](SUPPORT_MATRIX.md)

---

## 概要

**Thorium Browser 154（AVX-512 旗艦版）** は、**512 ビット AVX-512 拡張命令セット** を搭載する最新のハイエンド x86-64 プロセッサ向けに最適化されたフラグシップビルドです。最新の **Chromium 154 コア（`154.0.8023.0`）** に、**Thorium 152 の高性能マルチメディアマイクロカーネル、AV1/VP9 アセンブラ最適化、および低レイヤコンパイラフラグ** を完全統合しています。

`-march=skylake-avx512 -O3`、LLVM/Clang 23.0.0git、C++23、およびマルチスレッド ThinLTO（リンク時最適化）を適用し、32 本の 512 ビット `ZMM` レジスタ、ハードウェア文字列解析（`AVX-512BW`）、任意バイトシャッフル（`AVX-512VBMI`）、およびニューラルネットワーク演算（`AVX-512_VNNI`）を完全解放。DOM レイアウト、WebAssembly、V8 JIT 実行において最高峰の演算スループットを実現します。

> [!TIP]
> **AVX2 環境をお探しの方へ**：お使いのプロセッサが AVX-512 に非対応の場合（Intel 第4〜9世代、第12〜14世代非対応モデル、Xeon E3/E5 v3/v4、AMD Ryzen Zen 1〜3 など）、独立した [Thorium AVX2 リポジトリ](https://github.com/obhasashare2024-namo/thorium-avx2-rime) より専用パッケージをダウンロードしてください。

---

## 🌟 M154 ハイブリッドバージョンの主な特徴と技術ハイライト

### 1. Chromium 154 コア基盤 + Thorium 152 SIMD ハイブリッドアーキテクチャ
- **Chromium 154 コア更新**：ベースラインを `154.0.8023.0` に引き上げ、上流のセキュリティ強化、最新 Web API、洗練された Blink レイアウト性能を導入。
- **Thorium 152 マルチメディア最適化の移植**：Thorium 独自の高効率マルチメディアコーデック、AV1/VP9 SIMD アセンブラルーチン、最適化ビルドフラグを完全移植。
- **Clang 23.0 + C++23 ThinLTO**：モジュール間リンク時最適化により、バイナリサイズを最小限に圧縮。

### 2. 極限の 512 ビットベクトル演算能力（`-march=skylake-avx512`）
- `skylake-avx512`（AVX-512F, BW, CD, DQ, VL）をターゲットとし、ワークステーションやサーバー環境で最大の演算スループットを発揮。
- 32 本の 512 ビット `ZMM` レジスタを活用し、再レイアウトや WebAssembly SIMD 演算を大幅に加速。

### 3. 公式アトムロゴ Rebase、ゴールドアイコン＆プロセス完全分離（`thorium`）
PID 衝突、単一インスタンスロック競合（`SingletonLock`）、およびシステム側 Chromium や `webllm-farm` との干渉を根本解消：
- **公式アトムロゴの完全適用**：すべてのアイコンリソースを Thorium 公式アトムロゴ（16x16 〜 256x256）に置き換え、Chromium 丸型アイコンを完全排除。
- **About ページの UI スケール修正**：CSS `#productLogo { width: 32px; height: 32px; }` を適用しロゴ巨大化を防止。多言語ブランディング文字列を完備。
- **専用ゴールドアトムアイコン**：金属質感のゴールドアイコン（`assets/thorium-gold.png`）を同梱し、ファーム緑・標準紫プロファイルと即座に視覚識別可能。
- **カーネルプロセス名のハードニング**：バイナリ出力を `thorium` に固定し、`prctl(PR_SET_NAME, "thorium")` により `/proc/$PID/comm` を `thorium` に厳密固定。
- **独立した設定およびキャッシュディレクトリ**：`~/.config/thorium` および `~/.cache/thorium` を排他的に使用。
- **ウィンドウ識別子**：`StartupWMClass=thorium-browser`。

### 4. 公式 Google OAuth API 認証情報＆C++ Cookie 永続保護シールド
- **Google API キー内蔵**：ネイティブな Google アカウントログインおよび Chrome クラウド同期を復元。
- **`0005-account-reconcilor-cookie-shield-154.patch`**：Chromium 154 で改訂された `GoogleServiceAuthError` API に適応。`AccountReconcilor::PerformLogoutAllAccountsAction` を遮断し、ブラウザ再起動後も **Google アカウントが 100% ログイン状態を維持**。

### 5. RIME / Fcitx5 ネイティブ Wayland ＆ X11 IME 統合
- `--ozone-platform=wayland` および `WAYLAND_IM_MODULE=fcitx5` に完全対応、X11 への自動フォールバックも装備。
- GNOME 46/47 Mutter および KDE Plasma 6 KWin における候補ウィンドウの追従遅延・焦点喪失を根本解決。
- 動的な DBus セッションバスおよび Xauthority の自動検出。

### 6. Widevine CDM 保護ストリーミング再生
- `libwidevinecdm.so` モジュール登録と動的 CDM アダプタを統合。
- Netflix、Spotify、Disney+、Amazon Prime Video での 1080p/4K DRM 再生を実機検証済み。

### 7. 互換性およびツールチェーンパッチ
- **`0001-toolchain-segregation-avx512.patch`**：ターゲット AVX-512 フラグを `clang_x64_target` に分離し、異種ビルド機でのジェネレータクラッシュを防止。
- **`0006-signin-dbsc-buildflag-guard.patch`**：DBSC 登録を `#if BUILDFLAG(ENABLE_DEVICE_BOUND_SESSIONS)` で保護し、未定義シンボルエラーを解消。
- **`0007-crubit-rust-integrity-parser-fix.patch`**：Crubit Rust-C++ FFI パーサー結果の処理を修正。
- **`0008-thorium-m154-decoupling-and-packaging.patch`**：Debian、Arch Linux（`makepkg`）、ポータブル版にまたがる総合パッケージングおよびブランド分離パッチ。

---

## 📦 リリース資産および SHA-256 チェックサム

> [!IMPORTANT]
> **公式ダウンロード場所**：すべてのバイナリインストーラー、ポータブルアーカイブ、公式エンブレム、および検証マニフェストは、**[GitHub Releases Assets](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases/latest) 内でのみ配布されています**。リポジトリのソースページには直接ダウンロードリンクを配置していません。

| パッケージ | 形式 / 対象プラットフォーム | SHA-256 チェックサム |
| :--- | :--- | :--- |
| `Thorium_AVX512_154.0.8023.0_WIN64_Portable.zip` | Windows 64-bit AVX-512 ポータブル版アーカイブ | `12cf05d532bcefebe1c54b73b22416b80145c2ea0f46d3e1d16788db1f34ee64` |
| `thorium-browser_154.0.8023.0_AVX512.deb` | Debian / Ubuntu / Deepin / antiX | `d61a5234bbc83915cb868535e5c038f90f6644054c09bd12fa68d00750a1426d` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | Arch Linux / CachyOS / Artix | `1a651544265f3eded82b4c4a31bff085beee253c3abee61a27ddb9eab445b48e` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-portable.tar.gz` | 汎用 Linux ポータブル版 | `9208ebd6e26a74167a90d6ed43c4c1bc767b264f9f85df75965932889de19e5d` |
| `thorium-purple-lightning.png` | 公式高精度標準円紫雷エンブレム | `33973827dfb7ce1a23efa72e69c0d357502af299562d7bf97934f16b830e57a2` |
| `thorium-m154-avx512-suite.zip` | パッチ、設定ファイル、ビルドスクリプト一式 | `0af3f790cae9097205be546f187ddf6b23c07d0dd33f1260db6f2192c4e0d246` |
| `SHA256SUMS.txt` | リリース検証用チェックサムファイル | 全ファイルチェックサム |

---

## 📊 ベンチマーク測定結果

| 測定項目 | テスト環境 | ワークロード | 実測値 |
| :--- | :--- | :--- | :--- |
| **V8 エンジン演算スループット** | AVX-512（i5-1035G1） | Float64 行列乗算 (200x200) + Mandelbrot + 30k JSON | **`178.40 ms`** |
| **V8 エンジン演算スループット** | AVX2（デュアル Xeon E5-2696 v4） | Float64 行列乗算 (200x200) + Mandelbrot + 30k JSON | **`212.80 ms`** |
| **コールドスタート遅延** | AVX-512 | ヘッドレスコールド起動から DOM Ready まで | **`1180 ms`** |
| **Wayland IME 遅延** | AVX-512 | 候補ウィンドウポップアップ遅延 | **`< 2 ms`（ドリフトゼロ）** |

---

## ハードウェア互換性

### 対応 CPU（AVX-512）
* **Intel**：第10世代 Core (Ice Lake)、第11世代 Core (Tiger Lake / Rocket Lake)、Core X (Skylake-X / Cascade Lake-X)、Xeon Scalable (Gen 1-5)。
* **AMD**：Ryzen 7000 / 8000 / 9000 (Zen 4, Zen 5)、EPYC 9004 / 8004 / 9005。

> [!NOTE]
> 非 AVX-512 プロセッサ（Intel Haswell 〜 第14世代、Xeon E3/E5 v3/v4、AMD Zen 1〜3 など）をご利用の場合は、[Thorium AVX2 専用版](https://github.com/obhasashare2024-namo/thorium-avx2-rime) をご利用ください。

---

## ライセンス

BSD-3-Clause License。Chromium ソースコードは Chromium 作者のライセンス条項に準拠します。
