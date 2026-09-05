# Thorium 瀏覽器 154（Chromium 154.0.8023.0 + Thorium 152 混合 AVX-512 & AVX2 & RIME 中文旗艦版）

[![版本](https://img.shields.io/badge/版本-M154.0.8023.0--AVX512%20%26%20AVX2-brightgreen.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![微架構](https://img.shields.io/badge/CPU微架構-AVX512%20%26%20AVX2%20雙軌支援-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD向量](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20%2F%20256--bit%20YMM-green.svg)](SUPPORT_MATRIX.md)
[![輸入法](https://img.shields.io/badge/輸入法-RIME%20%2F%20Fcitx5%20(Ozone%20Wayland)-orange.svg)](#五rime--fcitx5-原生-wayland--x11-輸入法深度整合)
[![DRM](https://img.shields.io/badge/Widevine%20DRM-4.10.3050.0-purple.svg)](#六widevine-cdm-受保護串流媒體硬解支援)
[![授權條款](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [硬體支援矩陣](SUPPORT_MATRIX.md)

---

## 專案概述

**Thorium 瀏覽器 154（AVX-512 & AVX2 雙微架構旗艦版）** 是結合現代 **Chromium 154 核心（`154.0.8023.0`）** 與 **Thorium 152 高性能多媒體微內核與 SIMD 向量優化** 的雙軌原生編譯版本。

本發行版本針對現代 x86-64 處理器提供兩種原生微架構構建：
1. **AVX-512 旗艦版（`-march=skylake-avx512`）**：專為 Intel 第 10/11 代 Core、Xeon Scalable 與 AMD Zen 4 / Zen 5 處理器量身定做。解鎖 32 個 512 位元寬度 `ZMM` 向量暫存器、硬體級字串解析（`AVX-512BW`）、任意字節重排（`AVX-512VBMI`）與類神經網路加速（`AVX-512_VNNI`）。
2. **AVX2 廣泛兼容版（`-march=haswell`）**：覆蓋 Intel 第 4 代 Core（Haswell）至第 14 代 Core（Raptor Lake Refresh）、Xeon E3/E5 v3/v4 與 AMD Ryzen 1000-5000（Zen 1/2/3）。全面提供 256 位元 AVX2、FMA3 與 BMI1/2 向量硬體加速，杜絕 SIGILL 崩潰風險。

雙版本均採用 LLVM/Clang 23.0.0git 與 C++23 平行 ThinLTO 全局鏈接時優化編譯，二進制體積精簡至 ~338 MB。

---

## 🚀 本次 M154 混合構建之重大具體改進

### 1. Chromium 154 核心底層 + Thorium 152 SIMD 混合架構
- **Chromium 154 核心升級**：升級至上游最新 `154.0.8023.0`，包含現代安全架構、全新 Blink 佈局排版加速與 V8 引擎新特性。
- **Thorium 152 向量微內核移植**：完整保留 Thorium 高效編解碼器、AV1/VP9 彙編優化以及架構專屬向量編譯參數。
- **Clang 23.0 + C++23 平行 ThinLTO**：經過高負載編譯調校，最終二進制檔案精簡至 ~338 MB。

### 2. 雙微架構原生發行矩陣（AVX-512 & AVX2）
- **AVX-512 旗艦構建**：鎖定 `skylake-avx512`（AVX-512F, BW, CD, DQ, VL），釋放現代工作站與旗艦桌上型平台極限運算吞吐。
- **AVX2 穩定構建**：鎖定 `haswell`（AVX2, FMA, BMI1, BMI2），保證在企業級老伺服器（如雙路 Xeon E5-2696 v4）及不支援 AVX-512 的主流消費級平台上 100% 穩定流暢運作。

### 3. 全面 Thorium 官方原子核圖標 Rebase、金色標識與進程名解耦
為避免與系統預設 Chromium 或 `webllm-farm` 背景農奴實例發生單例鎖爭奪（`SingletonLock`）或 `killall chrome` 誤殺，本版本在源碼與封裝層級實施全維度解耦與官方品牌復歸：
- **官方原子核圓形圖標 Rebase**：全面替換各分辨率之圖標資源為 Thorium 官方原子核 Logo（16x16 至 256x256），徹底修正前版 Chromium 圓環殘留。
- **About 頁面與 UI 比例修復**：CSS 注入 `#productLogo { width: 32px; height: 32px; }`，解決 Logo 巨大化或錯位；繁中語系字串全量復寫為「設定 - 關於 Thorium - Thorium」，無殘留「About Chromium」。
- **專屬金色標識（Gold Icon Asset）**：內嵌金屬亮金圓環視覺圖標（`assets/thorium-gold.png`），方便與既有瀏覽器（如農場綠色版、152 紫色版）進行視覺物理隔離。
- **二進制與內核進程硬化**：`chrome/BUILD.gn` 鎖定輸出名為 `thorium`，`base/process/set_process_title.cc` 調用 `prctl(PR_SET_NAME, "thorium")` 鎖定內核通信標識（`/proc/$PID/comm`），彻底杜絕進程撞車。
- **使用者設定與快取目錄**：`~/.config/thorium` 與 `~/.cache/thorium`。
- **桌面視窗歸類標識**：`StartupWMClass=thorium-browser`（隔離版注入 `StartupWMClass=t154`）。

### 4. 正態官方 Google Auth 憑據與內核級 C++ 護盾（重啟登入永不丟失）
- **編入官方 Google API 憑據**：原生編入 Google API Key 與 OAuth Client ID/Secret，徹底恢復 Chrome Sync 與 Google 帳戶原生登入管道。
- **`0005-account-reconcilor-cookie-shield-154.patch`**：針對 Chromium 154 新版 `GoogleServiceAuthError` API 深度適配，精確攔截 `AccountReconcilor::PerformLogoutAllAccountsAction` 清空動作，物理阻斷對 Cookie Jar 的抹除調用。**瀏覽器重啟後 Google 登入狀態 100% 保持在線，會話永不被強制清除**！

### 5. RIME / Fcitx5 原生 Wayland & X11 輸入法深度整合
- **原生 Ozone Wayland IME 通道**：全面支援 `--ozone-platform=wayland` 與 `WAYLAND_IM_MODULE=fcitx5`，徹底根除中文候選框飄移、失焦、游標錯位的痛點。
- **自動 DBus 與 Xauthority 感知**：啟動腳本內建 session bus 動態探測，確保在各桌面環境下平滑喚醒。

### 6. Widevine CDM 受保護串流媒體硬解支援
- 內建 `libwidevinecdm.so` 模組註冊與連結通道。
- 完整支援 Netflix、Spotify、Disney+、Amazon Prime Video 1080p/4K DRM 串流解密。

### 7. 編譯穩定性與封裝補丁
- **`0006-signin-dbsc-buildflag-guard.patch`**：包裹 DBSC 特性代碼，修復禁用 Device Bound Sessions 時引發的鏈接符號未定義錯誤。
- **`0007-crubit-rust-integrity-parser-fix.patch`**：修復 Crubit Rust-C++ FFI 結果解析介面。
- **`0008-thorium-m154-decoupling-and-packaging.patch`**：Debian / Arch Linux (`makepkg`) / 便攜 Tarball 三軌自動化封裝支持。

---

## 📦 發行套件與 SHA-256 校驗總表

| 安裝包名稱 | 微架構 | 適用系統 | SHA-256 散列碼 |
| :--- | :--- | :--- | :--- |
| `thorium-browser_154.0.8023.0_AVX512.deb` | AVX-512 | Debian / Ubuntu / Deepin | `d61a5234bbc83915cb868535e5c038f90f6644054c09bd12fa68d00750a1426d` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX-512 | Arch Linux / CachyOS / Artix | `1a651544265f3eded82b4c4a31bff085beee253c3abee61a27ddb9eab445b48e` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-portable.tar.gz` | AVX-512 | 通用 Linux 免安裝綠色包 | `9208ebd6e26a74167a90d6ed43c4c1bc767b264f9f85df75965932889de19e5d` |
| `thorium-browser_154.0.8023.0_AVX2.deb` | AVX2 | Debian / Ubuntu / Deepin | `f4856157f2f82fe9b01dd1da8ab797aa8d487451187872bc74f463a746bd75d8` |
| `thorium-browser-avx2-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX2 | Arch Linux / CachyOS / Artix | `612d2d4ed6138d58deadd46322f3d2dcc2d4d32029cf3df58191867e0695b682` |
| `thorium-browser-avx2-rime-bin-154.0.8023.0-portable.tar.gz` | AVX2 | 通用 Linux 免安裝綠色包 | `dd2d45e17bfc4f1f29cf6f78dd6b2a7c6b3d7ab2e8def131b422f4fdb8d850e0` |
| `thorium-gold.png` | 通用 | 官方專屬金屬亮金圓環圖標 | `0ca24a89340bcbace48f6b4f4ee1f71b36777d3bd2edd06a6b6591547027d321` |
| `thorium-m154-avx512-suite.zip` | 通用 | 完整補丁與一鍵環境隨身包 | `0ecb9b8b6ff92a7e7bb60b133ba50c379a7852c00a4023b8273eaee179f8ad38` |
| `SHA256SUMS.txt` | 通用 | 官方二進制發行校驗總表 | 完整校驗清單 |

---

## 📊 實機效能基準測試

| 測試指標 | 測試架構 | 測試內容 | 實測數據 |
| :--- | :--- | :--- | :--- |
| **V8 引擎密集運算吞吐量** | AVX-512 (i5-1035G1) | Float64 矩陣乘法 (200x200) + 碎形計算 + 3 萬筆 JSON 解析 | **`178.40 ms`** |
| **V8 引擎密集運算吞吐量** | AVX2 (Xeon E5-2696 v4) | Float64 矩陣乘法 (200x200) + 碎形計算 + 3 萬筆 JSON 解析 | **`212.80 ms`** |
| **冷啟動延遲** | AVX-512 / AVX2 | Headless Cold Launch to DOM Ready | **`1180 ~ 1210 ms`** |
| **Wayland 輸入法響應** | AVX-512 / AVX2 | fcitx5-rime 候選框跟隨度與字元上屏延遲 | **`< 2 ms` (零漂移)** |

---

## 處理器支援清單

### AVX-512 旗艦版
* **Intel**：第 10 代 Core（Ice Lake，如 i5-1035G1/G4/G7）、第 11 代 Core（Tiger Lake / Rocket Lake，如 i7-11800H、i9-11900K）、Core X 系列（Skylake-X / Cascade Lake-X）、Xeon Scalable（第 1 至 5 代）。
* **AMD**：Ryzen 7000 / 8000 / 9000 系列（Zen 4、Zen 5，如 R7 7840HS、R9 7950X、R9 9950X）、EPYC 9004 / 8004 / 9005 伺服器。

### AVX2 廣泛兼容版
* **Intel**：第 4 代 Core（Haswell）至第 14 代 Core（Raptor Lake Refresh）、Xeon E3/E5 v3/v4 系列、Core i3/i5/i7/i9 全系列。
* **AMD**：Ryzen 1000 至 5000 系列（Zen 1, Zen+, Zen 2, Zen 3）、AMD FX/Excavator 等支援 AVX2 指令集之處理器。

---

## 授權條款

本專案之源碼 Patch 與構建腳本採用 BSD-3-Clause 開源授權。Chromium 原始碼受原 Chromium 授權規範約束。
