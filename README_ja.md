# Thorium Browser 151（Skylake-AVX512＆RIME IME対応版）

[![Architecture](https://img.shields.io/badge/Architecture-Skylake--AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD](https://img.shields.io/badge/SIMD-512--bit%20ZMM-green.svg)](SUPPORT_MATRIX.md)
[![IME](https://img.shields.io/badge/IME-RIME%20%2F%20Fcitx5-orange.svg)](#rime--fcitx5-日本語中国語入力統合)
[![GPU](https://img.shields.io/badge/GPU-RTX%203070%20%2F%20VA--API-purple.svg)](#ハードウェアアクセラレーション--gpu-オフロード)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [Support Matrix](SUPPORT_MATRIX.md)

---

## 概要

**Thorium Browser 151（AVX-512 対応版）** は、**AVX-512 命令セット** をサポートする最新の x86-64 プロセッサ（Intel 第10/11世代 Core、Xeon Scalable、および AMD Zen 4 / Zen 5）向けにビルドされた超高速 Chromium フォークです。

`-march=skylake-avx512` をターゲットにコンパイルすることで、完全な 512 ビット ベクトルレジスタ（`ZMM0`〜`ZMM31`）、ハードウェア レベルの文字列解析（`AVX-512BW`）、ベクトル バイト操作（`AVX-512VBMI`）、ニューラル ネットワーク命令（`AVX-512_VNNI`）、およびゼロコピー共有 GPU ラスタライズをフル活用します。

さらに、本ビルドは **RIME / Fcitx5** 入力メソッドの安定統合と **NVIDIA PRIME / VA-API** 独立 GPU ハードウェア動画デコードに完全対応しています。

---

## 主な機能と特徴

1. **純粋な AVX-512 最適化**:
   - Clang 19 および `-march=skylake-avx512 -O3 -flto=thin` でビルド。
   - V8 JavaScript JIT、WebAssembly、および Skia レンダリング パイプラインを 512 ビット レジスタでベクトル化。
   - `AVX-512BW` により DOM トークン化、UTF-8/UTF-16 エンコード、JSON パースを高速化。
   - `AVX-512_VNNI` によりブラウザ内 WebNN / ONNX 機械学習モデルを加速。
2. **RIME / Fcitx5 IME 長時間安定動作**:
   - D-Bus 自動検出フックを内蔵し、クライアント ウィンドウと Fcitx5 デーモンを直結。
   - ウィンドウ遮蔽保持フラグ（`--disable-features=CalculateNativeWinOcclusion`）により、長時間使用時の入力不能・フォーカス喪失を解消。
3. **NVIDIA PRIME ＆ 独立 GPU アクセラレーション**:
   - 自動 GPU オフロード（`__NV_PRIME_RENDER_OFFLOAD=1`、`__GLX_VENDOR_LIBRARY_NAME=nvidia`）を標準装備。
   - 4K/8K 60fps AV1/HEVC 再生時のゼロコピー フレームバッファ共有およびハードウェア VA-API/NVDEC デコードに対応。
4. **ビルドホスト分離ツールチェーン（Toolchain Segregation）**:
   - 独自の `clang_x64_target` ツールチェーン分離パッチを適用し、旧世代 AVX/AVX2 ホスト上でもジェネレータ ツール（`protoc`、`torque`、`cppgen`）のクラッシュなしにビルド可能。

---

## ハードウェア対応範囲

詳細は [SUPPORT_MATRIX.md](SUPPORT_MATRIX.md) をご参照ください：

- **対応（Intel）**: 第11世代 Core（Tiger Lake、Rocket Lake、例: i7-11800H）、第10世代 Core Mobile（Ice Lake）、Core X シリーズ（Skylake-X、Cascade Lake-X）、Xeon Scalable（第1〜第5世代）、Xeon W シリーズ。
- **対応（AMD）**: Ryzen 7000 / 8000 / 9000 シリーズ（Zen 4、Zen 5）、EPYC 9004 / 8004 / 9005 シリーズ、Ryzen Threadripper 7000 シリーズ。
- **非対応**: Intel Broadwell/Haswell/Ivy Bridge（例: E5-2696 v4、i7-4770）、AMD Zen 1〜Zen 3（Ryzen 1000〜5000）。*これらの環境では Thorium AVX または AVX2 ビルドをご利用ください。*

---

## インストール手順

### Debian / Ubuntu / antiX
```bash
sudo apt install ./packages/thorium-browser_151.0.7922.72_AVX512_RIME.deb
```

### Arch Linux / Artix Linux / Manjaro
```bash
sudo pacman -U ./packages/thorium-browser-avx512-rime-bin-151.0.7922.72-1-x86_64.pkg.tar.zst
```

---

## リポジトリ構成

```text
.
├── config/                  # AVX-512 GN ビルド構成
├── packaging/               # Arch / Debian パッケージ定義
├── patches/                 # ツールチェーン分離および WebUI パッチ
├── packages/                # SHA256SUMS（Releases ページでバイナリ配布）
├── scripts/                 # 自動ビルド パイプライン スクリプト
├── SUPPORT_MATRIX.md        # 詳細な CPU・命令セット対応表
├── README.md                # 英語ドキュメント
├── README_zh.md             # 繁体中国語ドキュメント
└── README_ja.md             # 日本語ドキュメント
```
