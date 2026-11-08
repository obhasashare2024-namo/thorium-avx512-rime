<p align="center">
  <img src="assets/thorium-purple-lightning.png" width="220" alt="Thorium Browser Emblem">
</p>

# Thorium 瀏覽器（官方 Chromium ＋ Thorium 雙軌混合編譯 AVX-512 與 RIME 旗艦版）

[![發布版本](https://img.shields.io/badge/發布版本-最新發布-blue.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases)
[![雙軌混合編譯](https://img.shields.io/badge/雙軌混合編譯-官方%20Chromium%20%2B%20Thorium-blueviolet.svg)](#-雙軌混合編譯架構與源流溯源-hybrid-compilation-architecture)
[![微架構](https://img.shields.io/badge/微架構-Skylake--AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD向量](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20(實測驗證)-green.svg)](SUPPORT_MATRIX.md)
[![輸入法](https://img.shields.io/badge/輸入法-RIME%20%2F%20Fcitx5%20(零穿透)-orange.svg)](#二rime--fcitx5-中文輸入法深度整合與免疫門禁)
[![顯示平台](https://img.shields.io/badge/顯示平台-自適應%20Ozone%20(Wayland%2FX11)-purple.svg)](#三雙顯動態自適應平台adaptive-ozone-platform-gate)
[![OAuth認證](https://img.shields.io/badge/Google%20OAuth-官方原生憑證-brightgreen.svg)](#四google-官方-oauth-20-api-憑證原生整合)
[![授權條款](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)
[![AVX2 旗艦版](https://img.shields.io/badge/AVX2%20旗艦版-點此前往-green.svg)](https://github.com/obhasashare2024-namo/thorium-avx2-rime)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [硬體支援矩陣](SUPPORT_MATRIX.md) | [架構手冊](HANDOFF_M159.md)

---

## 🧬 雙軌混合編譯架構與源流溯源 (Hybrid Compilation Architecture)

> [!IMPORTANT]
> **混合源碼血統聲明**：本專案為**雙軌混合編譯（Dual-Track Hybrid Compilation）旗艦版本**，深度融合 **官方 Chromium 最新版**（最新 Upstream 核心源碼樹）與 **Thorium 最新版**（`Alex313031/Thorium` 效能優化與指令集補丁庫），並深度注入自研的 Linux RIME / Fcitx5 七重免疫門禁、自適應 Ozone 顯示平台與登入防踢出強化補丁。

```mermaid
graph TD
    A["官方 Chromium 上游源碼樹 (最新版)"] --> D["混合源碼樹 (AVX-512)"]
    B["Thorium 最新補丁庫 (AVX-512 SIMD / ThinLTO / 編解碼 / 紫標主題)"] --> D
    C["自研 C++ 硬核補丁庫 (RIME 免疫門禁 / 自適應 Ozone / 登入防踢出)"] --> D
    D --> E["GN 向量配置 (args_avx512.gn)"]
    E --> F["Clang + ThinLTO + 512 位元 ZMM 編譯引擎"]
    F --> G["原生實體二進制與安裝包 (.deb / .tar.xz)"]
```

| 架構層級 | 源碼來源 | 核心貢獻與技術實作細節 |
| :--- | :--- | :--- |
| **底層瀏覽器內核** | **官方 Chromium 核心 (最新版)** | 享受 Chromium 最新上游安全補丁、全新 V8 JavaScript JIT 引擎、WebAssembly 擴展與現代 Web 協議棧。 |
| **效能與多媒體庫** | **Thorium 最新版** (`Alex313031/Thorium`) | 移植 Skylake-AVX512 向量旗標、ThinLTO 鏈接期優化、全開專有媒體編解碼（HEVC/Dolby Vision/AC3/VA-API）、Thorium 官方 API Key 與紫雷視覺標識。 |
| **RIME 免疫門禁** | **自研補丁 Patch 0003** | 在 `input_method_auralinux.cc` 注入 7 層組字攔截（`!composition_.text.empty()`），徹底阻斷 raw Latin 按鍵穿透與快捷鍵誤爆。 |
| **Profile 硬隔離** | **自研補丁 Patch 0004** | 強制設定檔寫入 `~/.config/thorium`，與原生 Chromium 數據零衝突、零覆蓋。 |
| **帳號會話持久化** | **自研補丁 Patch 0005** | 徹底移除 DICE 與 DBSC 憑證綁定，阻斷系統重啟時 Gaia Cookie Jar 主動抹除，解決 Google / YouTube 重啟掉登入。 |
| **基本密鑰提供者** | **自研補丁 Patch 0006** | 預設鎖定 OSCrypt Basic (`peanuts` / v10 key)，擺脫對 D-Bus Secret Service / KWallet 的硬依賴。 |
| **SQLite WAL 落盤** | **自研補丁 Patch 0007** | 收到 SIGTERM 時強制執行 `PRAGMA wal_checkpoint(TRUNCATE)`，物理確證 Cookie 與會話完整性。 |
| **雙顯自適應自舉** | **自研 Delegate 邏輯** | 啟動時自動探測 Wayland 與 X11 環境，Wayland 優先並自動降級 X11，防止純 Wayland 環境啟動崩潰。 |

---

## 專案概述

**Thorium 瀏覽器（純血 AVX-512 旗艦版）** 是專為支援 **AVX-512 向量指令集** 的現代 x86-64 處理器（Intel 第 10/11 代 Core、Xeon Scalable、以及 AMD Zen 4 / Zen 5）量身客製的頂級極速 Chromium 發布版。本專案將官方 Chromium 核心與 Thorium 多媒體微內核、AV1/VP9 SIMD 組合語言函式庫及深度硬體加速管線完美融合。

透過全量注入 `-march=skylake-avx512 -O3 -flto=thin -mavx512f -mavx512cd -mavx512vl -mavx512bw -mavx512dq -mno-gather -mno-scatter -ffp-contract=fast` 編譯架構，本版本解鎖了 CPU 內部的 32 個 512 位元寬度 `ZMM` 向量暫存器、硬體級字串解析（`AVX-512BW`）、字節任意排列與類神經網路加速。二進制反編譯（`objdump -d`）確證啟用數千處原生向量指令。

同時，本版本整合了經過實機隔離測試檢驗的 **RIME（中州韻）/ Fcitx5 七重立體防禦門禁**（空格上屏「能上」，0 字母穿透）與 **雙顯動態自適應平台**（Wayland / X11 自舉），並內嵌 Google 官方 OAuth 2.0 憑證。

---

## 核心亮點與技術特性

### 一、純血 AVX-512 指令集全量向量化
* 採用 Clang、LLVM lld、C++23 與全域 ThinLTO 深度優化；
* 向量旗標：`-march=skylake-avx512 -O3 -mavx512f -mavx512cd -mavx512vl -mavx512bw -mavx512dq`；
* V8 JavaScript JIT、WebAssembly 與 Skia 圖形渲染流水線全量跑在 512 位元暫存器上；
* `AVX-512BW` 大幅加速 DOM 語法剖析、UTF-8/UTF-16 轉碼與 JSON 序列化。

### 二、RIME / Fcitx5 中文輸入法深度整合與免疫門禁
* 內核整合 `THORIUM_RIME_IMMUNE_GATE` 門禁；
* 當處於組字中（`!composition_.text.empty()`）時，嚴格攔截 raw Latin 按鍵傳播至 DOM，徹底根治敲拼音漏字母（如輸入 `shang` 漏出 `s` 跳出設定選單）與候選框脫離焦點問題；
* 通過物理實機隔離測試（`isolated-app-testing`），完美上屏中文。

### 三、雙顯動態自適應平台（Adaptive Ozone Platform Gate）
* `chrome_main_delegate.cc` 注入動態自舉探查邏輯；
* 自動嗅探 `$WAYLAND_DISPLAY` 與 `$DISPLAY`，純 Wayland 環境下原生自舉 Wayland，X11 環境自動回退 GTK4/X11，徹底杜絕無 X 伺服器機器崩潰閃退。

### 四、Google 官方 OAuth 2.0 API 憑證原生整合
* 內置官方 Thorium API Key 與 Client ID；
* 完美支援 Google 帳號網頁 SSO 登錄、帳號同步及 Chrome Web Store 擴充功能安裝。

### 五、Thorium Purple 經典紫標典藏主題
* 專屬紫曜太極圖標與高清視覺主題包（16px ~ 512px）；
* 核心級移除啟動時的黃色 `--no-sandbox` 警告橫幅。

---

## 預編譯二進制資產

可由 [GitHub Releases](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases) 取得最新發布安裝包：

| 檔案名稱 | 類型 | 檔案大小 | 備註說明 |
| :--- | :--- | :--- | :--- |
| `thorium-browser-stable_*_amd64.deb` | Debian/Ubuntu 64 位元安裝包 | ~128 MB | 官方標準打包，具備系統桌面圖標與 MIME 協議整合 |
| `thorium-browser_*_AVX512_RIME.deb` | Debian/Ubuntu 相容別名包 | ~128 MB | 專屬相容別名包 |
| `thorium-browser-*-avx512-linux-x64.tar.xz` | Linux 便攜式綠色歸檔包 | ~153 MB | 免安裝綠色解壓即用版（免 root 權限） |
| `SHA256SUMS.txt` | 校驗值總清單 | 文字 | Releases 頁面提供之 SHA256 數位簽章 |

---

## 快速上手與部署

### Debian / Ubuntu / Linux Mint
```bash
sudo dpkg -i thorium-browser-stable_*_amd64.deb
sudo apt-get install -f # 如遇缺依賴自動修復補齊
thorium-browser
```

### Arch Linux / CachyOS / Artix / Manjaro
```bash
tar -xf thorium-browser-*-avx512-linux-x64.tar.xz
cd thorium-browser-*-avx512-linux-x64
./chrome
```

---

## 硬體相容性指南

* **完整支援（Intel）**：第 11 代 Core（Tiger Lake、Rocket Lake，如 i7-11800H）、第 10 代 Core 移動版（Ice Lake）、Core X 系列（Skylake-X、Cascade Lake-X）、Xeon Scalable（第 1 至 5 代）、Xeon W 系列。
* **完整支援（AMD）**：Ryzen 7000 / 8000 / 9000 系列（Zen 4、Zen 5）、EPYC 9004 / 8004 / 9005 系列、Ryzen Threadripper 7000 系列。
* **非 AVX-512 機器**：Intel Haswell ~ Comet Lake 或 AMD Zen 1 ~ Zen 3 處理器，請前往使用 [Thorium AVX2 旗艦版](https://github.com/obhasashare2024-namo/thorium-avx2-rime)。

---

## 授權條款

Thorium 修改與編譯工具鏈腳本以 BSD-3-Clause 開源授權協議發布。Chromium 原代碼受其官方開源協議保護。
