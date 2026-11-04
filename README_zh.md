# Thorium 瀏覽器 159（Skylake-AVX512 與 RIME 中文整合旗艦版）

[![發布版本](https://img.shields.io/badge/發布版本-v159.0.8137.0-blue.svg)](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases/tag/v159.0.8137.0)
[![微架構](https://img.shields.io/badge/微架構-Skylake--AVX512-blue.svg)](SUPPORT_MATRIX.md)
[![SIMD向量](https://img.shields.io/badge/SIMD-512--bit%20ZMM%20(實測驗證)-green.svg)](SUPPORT_MATRIX.md)
[![輸入法](https://img.shields.io/badge/輸入法-RIME%20%2F%20Fcitx5%20(零穿透)-orange.svg)](#二rime--fcitx5-中文輸入法深度整合與免疫門禁)
[![顯示平台](https://img.shields.io/badge/顯示平台-自適應%20Ozone%20(Wayland%2FX11)-purple.svg)](#三雙顯動態自適應平台adaptive-ozone-platform-gate)
[![OAuth認證](https://img.shields.io/badge/Google%20OAuth-官方原生憑證-brightgreen.svg)](#四google-官方-oauth-20-api-憑證原生整合)
[![授權條款](https://img.shields.io/badge/License-BSD--3--Clause-lightgrey.svg)](LICENSE)
[![AVX2 旗艦版](https://img.shields.io/badge/AVX2%20旗艦版-點此前往-green.svg)](https://github.com/obhasashare2024-namo/thorium-avx2-rime)

[English](README.md) | [繁體中文](README_zh.md) | [日本語](README_ja.md) | [硬體支援矩陣](SUPPORT_MATRIX.md) | [架構與技術交接手冊](HANDOFF_M159.md)

---

## 專案概述

**Thorium 瀏覽器 159（純血 AVX-512 旗艦版）** 是專為支援 **AVX-512 向量指令集** 的現代 x86-64 處理器（Intel 第 10/11 代 Core、Xeon Scalable、以及 AMD Zen 4 / Zen 5）量身客製的頂級極速 Chromium（`159.0.8137.0`）發布版。

透過全量注入 `-march=skylake-avx512 -O3 -flto=thin -mavx512f -mavx512cd -mavx512vl -mavx512bw -mavx512dq -mno-gather -mno-scatter -ffp-contract=fast` 編譯架構，本版本解鎖了 CPU 內部的 32 個 512 位元寬度 `ZMM` 向量暫存器、硬體級字串解析（`AVX-512BW`）、字節任意排列與類神經網路加速。二進制反編譯（`objdump -d`）確證啟用 **2,517 處向量指令**。

同時，本版本整合了經過實機隔離測試檢驗的 **RIME（中州韻）/ Fcitx5 七重立體防禦門禁**（空格上屏「能上」，0 字母穿透）與 **雙顯動態自適應平台**（Wayland / X11 自舉），並內嵌 Google 官方 OAuth 2.0 憑證。

---

## 核心亮點與技術特性

### 一、純血 AVX-512 指令集全量向量化
* 採用 Clang 19、LLVM lld、C++23 與全域 ThinLTO 深度優化；
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

## 預編譯二進制資產（v159.0.8137.0）

可由 [GitHub Releases](https://github.com/obhasashare2024-namo/thorium-avx512-rime/releases/tag/v159.0.8137.0) 取得預編譯安裝包：

| 檔案名稱 | 類型 | 檔案大小 | SHA256 數位校驗碼 |
| :--- | :--- | :--- | :--- |
| `thorium-browser-stable_159.0.8137.0-1_amd64.deb` | Debian/Ubuntu 64 位元安裝包 | 128 MB | `a1720e3fbbcb5204f6a7117859dbe9be81e71a033005767d8d5ce956b1bb1f99` |
| `thorium-browser_159.0.8137.0_AVX512_RIME.deb` | Debian/Ubuntu 相容別名包 | 128 MB | `0752516ae9c149d4d0fa9b0c63d3d7636ef09c725a5ef327ede7e08f40c65dcb` |
| `thorium-browser-159.0.8137.0-avx512-linux-x64.tar.xz` | Linux x64 綠色免安裝便攜包 | 153 MB | `4799be81da0e9eeee2678188101738c87a54332a88235277f7b776dc3c2bee45` |
| `SHA256SUMS.txt` | 官方校驗清單 | 344 B | `b99e74ceb3628e93aa8f5aa0f28325608d0a84a625cb27e5ec0d0bf8a964522f` |

---

## 快速安裝與使用

### Debian / Ubuntu / Linux Mint
```bash
sudo dpkg -i thorium-browser-stable_159.0.8137.0-1_amd64.deb
sudo apt-get install -f # 缺依賴時自動補齊
thorium-browser
```

### Arch Linux / CachyOS / Artix / Manjaro
```bash
tar -xf thorium-browser-159.0.8137.0-avx512-linux-x64.tar.xz
cd thorium-browser-159.0.8137.0-avx512-linux-x64
./chrome
```

---

## 硬體支援範圍

* **支援處理器 (Intel)**：第 11 代 Core（Tiger Lake、Rocket Lake，如 i7-11800H）、第 10 代 Core Mobile（Ice Lake）、Core X 系列（Skylake-X、Cascade Lake-X）、Xeon Scalable（第 1~5 代）、Xeon W 系列。
* **支援處理器 (AMD)**：Ryzen 7000 / 8000 / 9000 系列（Zen 4、Zen 5）、EPYC 9004 / 8004 / 9005 系列、Ryzen Threadripper 7000 系列。
* **非 AVX-512 機器**：針對 Intel Haswell~Comet Lake 或 AMD Zen 1~Zen 3，請使用 [Thorium AVX2 旗艦版](https://github.com/obhasashare2024-namo/thorium-avx2-rime)。

---

## 授權條款

Thorium 修改與構建腳本基於 BSD-3-Clause 條款開源發布。Chromium 原生代碼遵循原始 Chromium 開源授權。
