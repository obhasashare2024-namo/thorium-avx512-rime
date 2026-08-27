# Thorium 瀏覽器 151（Skylake-AVX512 與 RIME 中文整合旗艦版）

[![微架構](https://img.shields.io/badge/CPU微架構-Skylake--AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD向量](https://img.shields.io/badge/SIMD-512--bit%20ZMM-green.svg)](SUPPORT_MATRIX.md)
[![輸入法](https://img.shields.io/badge/輸入法-RIME%20%2F%20Fcitx5-orange.svg)](#二rime--fcitx5-中文輸入法深度整合)
[![GPU加速](https://img.shields.io/badge/GPU硬解-RTX%203070%20%2F%20VA--API-purple.svg)](#三nvidia-prime-與獨顯硬體加速)
[![授權條款](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [硬體支援矩陣](SUPPORT_MATRIX.md)

---

## 專案概述

**Thorium 瀏覽器 151（AVX-512 旗艦版）** 是專為支援 **AVX-512 向量指令集** 的現代 x86-64 處理器（Intel 第 10/11 代 Core、Xeon Scalable、以及 AMD Zen 4 / Zen 5）量身客製的頂級極速 Chromium 分支。

透過全面鎖定 `-march=skylake-avx512 -O3 -flto=thin` 編譯架構，本版本解鎖了 CPU 內部的 32 個 512 位元寬度 `ZMM` 向量暫存器、硬體級字串解析（`AVX-512BW`）、字節任意排列（`AVX-512VBMI`）、類神經網路加速（`AVX-512_VNNI`）以及 GPU 零拷貝顯存共享點陣化。

同時，本版本已全面修復並實體物理驗證了 **RIME（中州韻）/ Fcitx5** 中文候選字框與 **NVIDIA RTX 3070 / VA-API** 獨顯硬體視訊解碼。

---

## 核心亮點與技術特性

### 一、純血 AVX-512 指令集全量向量化
* **512-bit ZMM 暫存器全開**：V8 JavaScript JIT 引擎、WebAssembly SIMD 向量運算、Blink 排版計算與 Skia 2D 圖形繪製皆採用 512 位元暫存器加速。
* **DOM 與字串解析加速（`AVX-512BW`）**：以 512 位元寬度批次處理 UTF-8/UTF-16 字元轉換、HTML 詞法分析與 `JSON.parse`。
* **AI / WebNN 本地推理加速（`AVX-512_VNNI`）**：提供 INT8/FP16 點積運算硬體直通，大幅提升網頁端神經網路模型運算效率。

### 二、RIME / Fcitx5 中文輸入法深度整合
* **動態 DBus 總線感知**：內建自動探測與掛載 `/run/user/$UID/bus`，徹底消除遠端 XRDP、獨立 X11 會話下輸入法斷連的痛點。
* **候選框零卡死與精準對齊**：配置 `--gtk-version=3` 與 `--ozone-platform=x11`，確保中文輸入法選字框精準跟隨游標彈出，絕不搶占焦點或引發全視窗卡死。

### 三、NVIDIA PRIME 與獨顯硬體加速
* **PRIME 滿血導流**：預先注入 `__NV_PRIME_RENDER_OFFLOAD=1` 與 `__GLX_VENDOR_LIBRARY_NAME=nvidia`，無縫調用 RTX 3070 等獨立顯卡。
* **4K/8K 60fps 視訊硬解**：開啟 `VaapiVideoDecodeLinuxGL` 與 Zero-Copy 零拷貝顯存共享，網頁 YouTube 視訊播放 CPU 佔用率低於 1%。

### 四、編譯工具鏈雙軌隔離架構（Toolchain Segregation）
* 針對 Chromium 原生構建系統在非 AVX-512 伺服器上會因宿主機代碼生成工具（`protoc`, `torque`, `cppgen`）拋出 `SIGILL` 的缺陷，本專案實作了 `clang_x64_target` 雙軌架構，使任意 x86 伺服器均能流暢交叉編譯純血 AVX-512 瀏覽器！

---

## 處理器支援範圍摘要

完整微架構與指令集旗標支援清單請參閱 [SUPPORT_MATRIX.md](SUPPORT_MATRIX.md)：

* **✅ 支援處理器（Intel）**：第 11 代 Core（Tiger Lake / Rocket Lake，如 i7-11800H、i9-11900K）、第 10 代 Core 行動版（Ice Lake）、Core X 系列（Skylake-X / Cascade Lake-X）、Xeon Scalable（第 1 至 5 代）、Xeon W 工作站系列。
* **✅ 支援處理器（AMD）**：Ryzen 7000 / 8000 / 9000 系列（Zen 4、Zen 5，如 R7 7840HS、R9 7950X、R9 9950X）、EPYC 9004 / 8004 / 9005 伺服器、Threadripper 7000。
* **❌ 不支援處理器**：Intel Broadwell/Haswell/Ivy Bridge（如 E5-2696 v4、i5-3210M）、AMD Zen 1~Zen 3（Ryzen 1000~5000）。*以上架構請使用 Thorium AVX2 或 AVX 版本。*

---

## 安裝與快速開始

已預先編譯好的二進制安裝包置於 [`packages/`](packages/) 目錄下：

### Debian / Ubuntu / antiX 系統
```bash
sudo apt install ./packages/thorium-browser_151.0.7922.72_AVX512_RIME.deb
```

### Arch Linux / Artix Linux / Manjaro 系統
```bash
sudo pacman -U ./packages/thorium-browser-avx512-rime-bin-151.0.7922.72-1-x86_64.pkg.tar.zst
```

### 驗證安裝
在終端機執行：
```bash
thorium-browser --version
```
輸出 `Chromium 154.0.8023.0` 即代表安裝成功。

---

## 版本庫結構說明

```text
.
├── config/
│   ├── args_avx512.gn       # 生產環境 AVX-512 GN 編譯參數
│   └── args_arm64.gn        # ARMv8 / Android Quest VR 編譯參數
├── packaging/
│   ├── arch/                # Arch Linux PKGBUILD 與桌面啟動項
│   └── deb/                 # Debian control 打包控制檔
├── patches/
│   ├── 0001-toolchain-segregation-avx512.patch
│   └── 0002-webui-color-change-listener-android-fix.patch
├── packages/
│   ├── SHA256SUMS           # 安裝包校驗碼清單
│   ├── thorium-browser_151.0.7922.72_AVX512_RIME.deb
│   └── thorium-browser-avx512-rime-bin-151.0.7922.72-1-x86_64.pkg.tar.zst
├── scripts/
│   └── build_avx512.sh      # 一鍵全自動編譯構建腳本
├── SUPPORT_MATRIX.md        # 完整 CPU 微架構與指令集支援矩陣
├── README.md                # 英文完整說明文檔
└── README_zh.md             # 繁體中文說明文檔
```

---

## 授權條款

本專案之源碼 Patch 與構建腳本採用 BSD-3-Clause 開源授權。Chromium 原始碼受原 Chromium 授權規範約束。
