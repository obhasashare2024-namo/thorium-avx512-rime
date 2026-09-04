# Thorium 瀏覽器 154（Chromium 154.0.8023.0 + Thorium 152 混合 AVX-512 & RIME 中文旗艦版）

[![版本](https://img.shields.io/badge/版本-M154.0.8023.0--AVX512-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![微架構](https://img.shields.io/badge/CPU微架構-IceLake%20%2F%20TigerLake%20%2F%20Zen4--5%20AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD向量](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20Vectors-green.svg)](SUPPORT_MATRIX.md)
[![輸入法](https://img.shields.io/badge/輸入法-RIME%20%2F%20Fcitx5%20(Ozone%20Wayland)-orange.svg)](#四rime--fcitx5-原生-wayland-輸入法深度整合)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#五widevine-cdm-受保護串流媒體硬解支援)
[![授權條款](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [硬體支援矩陣](SUPPORT_MATRIX.md)

---

## 專案概述

**Thorium 瀏覽器 154（AVX-512 旗艦版）** 是結合現代 **Chromium 154 核心（`154.0.8023.0`）** 與 **Thorium 152 高性能多媒體微內核與 AVX-512 向量優化** 的雙軌混合編譯版本。

專為支援 **AVX-512 向量指令集** 的現代 x86-64 處理器（Intel 第 10/11 代 Core、Xeon Scalable、以及 AMD Zen 4 / Zen 5）量身客製。採用最新 LLVM/Clang 23.0.0git 與 C++23 標準編譯，解鎖 CPU 內部的 32 個 512 位元寬度 `ZMM` 向量暫存器、硬體級字串解析（`AVX-512BW`）、字節任意排列（`AVX-512VBMI`）、類神經網路加速（`AVX-512_VNNI`）以及 GPU 零拷貝顯存共享點陣化。

---

## 🚀 本次 M154 混合構建之重大具體改進

### 1. Chromium 154 核心底層 + Thorium 152 SIMD 混合架構
- **Chromium 154 核心升級**：升級至上游最新 `154.0.8023.0`，包含現代安全架構、全新 Blink 佈局排版加速與 V8 引擎新特性。
- **Thorium 152 向量微內核移植**：完整保留 Thorium 高效編解碼器、AV1/VP9 彙編優化以及專屬編譯優化參數（`-O3 -mavx512f -mavx512dq -mavx512cd -mavx512bw -mavx512vl`）。
- **Clang 23.0 + C++23 平行 ThinLTO**：經過高負載編譯調校，最終二進制檔案精簡至 338 MB。

### 2. 全維度 10 大核心位置改名與解耦（`thorium`，徹底杜絕 PID 撞車）
為避免與系統預設 Chromium 或 `webllm-farm` 背景農奴實例發生單例鎖爭奪（`SingletonLock`）或 `killall chrome` 誤殺，本版本在源碼與封裝層級實施全維度解耦：
- 二進制產物命名：`thorium`
- 內核進程通信標識（`/proc/$PID/comm`）：`thorium`
- 使用者設定目錄：`~/.config/thorium`
- 快取緩存目錄：`~/.cache/thorium`
- 桌面視窗歸類標識：`StartupWMClass=thorium-browser`
- 桌面快捷圖標與包裝腳本：完全獨立，互不干擾。

### 3. 正態官方 Google Auth 憑據與內核級 C++ 護盾（重啟登入永不丟失）
- **編入官方 Google API 憑據**：原生編入 Google API Key 與 OAuth Client ID/Secret，徹底恢復 Chrome Sync 與 Google 帳戶原生登入管道。
- **`0005-account-reconcilor-cookie-shield-154.patch`**：針對 Chromium 154 新版 `GoogleServiceAuthError` API 深度適配，精確攔截 `AccountReconcilor::PerformLogoutAllAccountsAction` 清空動作，物理阻斷對 Cookie Jar 的抹除調用。**瀏覽器重啟後 Google 登入狀態 100% 保持在線，會話永不被強制清除**！

### 4. RIME / Fcitx5 原生 Wayland & X11 輸入法深度整合
- **原生 Ozone Wayland IME 通道**：全面支援 `--ozone-platform=wayland` 與 `WAYLAND_IM_MODULE=fcitx5`，徹底根除中文候選框飄移、失焦、游標錯位的痛點。
- **自動 DBus 與 Xauthority 感知**：啟動腳本內建 session bus 動態探測，確保在各桌面環境下平滑喚醒。

### 5. Widevine CDM 受保護串流媒體硬解支援
- 內建 `libwidevinecdm.so` 模組註冊與連結通道。
- 完整支援 Netflix、Spotify、Disney+、Amazon Prime Video 1080p/4K DRM 串流解密。

### 6. 編譯穩定性與封裝補丁
- **`0006-signin-dbsc-buildflag-guard.patch`**：包裹 DBSC 特性代碼，修復禁用 Device Bound Sessions 時引發的鏈接符號未定義錯誤。
- **`0007-crubit-rust-integrity-parser-fix.patch`**：修復 Crubit Rust-C++ FFI 結果解析介面。
- **`0008-thorium-m154-decoupling-and-packaging.patch`**：Debian / Arch Linux (`makepkg`) / 便攜 Tarball 三軌自動化封裝支持。

---

## 📊 實機效能基準測試（Intel Core i5-1035G1 Ice Lake AVX-512）

| 測試指標 | 測試內容 | 實測數據 |
| :--- | :--- | :--- |
| **V8 引擎密集運算吞吐量** | Float64 矩陣乘法 (200x200) + 碎形計算 + 3 萬筆 JSON 解析 | **`178.40 ms`** |
| **冷啟動延遲** | Headless Cold Launch to DOM Ready | **`1210.15 ms`** |
| **Wayland 輸入法響應** | fcitx5-rime 候選框跟隨度與字元上屏延遲 | **`< 2 ms` (零漂移)** |

---

## 處理器支援清單

* **✅ 完全支援處理器（Intel）**：
  - 第 10 代 Core（Ice Lake，如 i5-1035G1/G4/G7）
  - 第 11 代 Core（Tiger Lake / Rocket Lake，如 i7-11800H、i9-11900K）
  - Core X 系列（Skylake-X / Cascade Lake-X）
  - Xeon Scalable（第 1 至 5 代）
* **✅ 完全支援處理器（AMD）**：
  - Ryzen 7000 / 8000 / 9000 系列（Zen 4、Zen 5，如 R7 7840HS、R9 7950X、R9 9950X）
  - EPYC 9004 / 8004 / 9005 伺服器
* **❌ 不支援處理器**：Intel Broadwell/Haswell/Ivy Bridge（如 E5-2696 v4 實測精確拋出 SIGILL `Illegal instruction`）、AMD Zen 1~Zen 3。

---

## 授權條款

本專案之源碼 Patch 與構建腳本採用 BSD-3-Clause 開源授權。Chromium 原始碼受原 Chromium 授權規範約束。
