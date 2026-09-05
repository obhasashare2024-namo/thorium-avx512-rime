# Thorium Browser v154.0.8023.0 (AVX-512 & AVX2 & RIME 金色旗舰版)

次世代 **Chromium 154（154.0.8023.0）** 核心引擎與 **Thorium 152** 極致效能架構之雙軌微架構旗艦發行版本，提供 **AVX-512** 與 **AVX2** 雙原生編譯構建。

---

### 🚀 核心升級與重大改進

1. **雙微架構原生支援（AVX-512 & AVX2）**
   - **AVX-512 旗艦版**：鎖定 `skylake-avx512`（AVX-512F, AVX-512BW, AVX-512CD, AVX-512DQ, AVX-512VL），釋放 32 個 512 位元 ZMM 向量暫存器極致效能。
   - **AVX2 廣泛兼容版**：鎖定 `haswell`（AVX2, FMA3, BMI1/2），覆蓋 Intel 4 代至 14 代 Core 及 AMD 全系列 Zen 架構。
   - 啟用 Clang 23.0 + C++23 平行 ThinLTO 全局鏈接時優化，二進制體積精簡至 ~339 MB。

2. **Patch 0005: AccountReconcilor C++ Cookie Shield 登入持久化護盾**
   - 深度適配 Chromium 154 新版 `GoogleServiceAuthError` API，精確攔截 `AccountReconcilor::PerformLogoutAllAccountsAction` 清空調用。
   - **實機驗證確認**：瀏覽器或系統重啟後 Google 帳號維持登入，徹底終結第三方編譯版「重啟掉登入」的長年痛點。

3. **RIME / Fcitx5 原生 Wayland & X11 輸入法深度整合**
   - 支援原生 Wayland Ozone `text-input-v1/v2/v3` 協議。
   - 輸入法上下文防奪焦點守護，解決候選框飄移、失焦、游標錯位問題，在任何網頁按 `Ctrl+Space` 即時無延遲喚出 RIME 候選窗。

4. **Widevine CDM 受保護串流媒體與專有解碼全開**
   - 內置 `libwidevinecdm.so` 模組連結通道，原生支援 Netflix 1080p、Spotify、Disney+、Apple Music 高規格串流。
   - 全解禁 HEVC (H.265)、Dolby Vision、Dolby Audio (AC3/E-AC3) 與 VA-API GPU 硬體加速。

5. **全方位官方原子核 Logo Rebase、金色標識與進程名解耦**
   - 替換全分辨率官方 Thorium 原子核圖標資源（16x16 至 256x256），修復前版 Chromium 圓環殘留。
   - 深入 `resources.pak`、`chrome_100_percent.pak`、`chrome_200_percent.pak` 替換內部商標，About 頁面原生呈現純金 Logo。
   - 系統各解析度圖標與桌面捷徑全面同步為金屬亮金圓環視覺圖標（`thorium-gold.png`），方便與現有各版本進行物理桌面隔離。
   - 二進制命名與內核 `/proc/$PID/comm` 雙重硬化為 `thorium`，徹底杜絕單例鎖爭用與 `killall chrome` 誤殺。

---

### 📦 發行套件與 SHA-256 校驗總表

| 附件檔案 | 微架構 | 適用系統 | 檔案大小 | SHA-256 校驗碼 |
| :--- | :--- | :--- | :--- | :--- |
| `thorium-browser_154.0.8023.0_AVX512.deb` | AVX-512 | Debian / Ubuntu / Deepin | 217 MB | `d61a5234bbc83915cb868535e5c038f90f6644054c09bd12fa68d00750a1426d` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX-512 | Arch Linux / CachyOS / Artix | 279 MB | `1a651544265f3eded82b4c4a31bff085beee253c3abee61a27ddb9eab445b48e` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-portable.tar.gz` | AVX-512 | 通用 Linux 免安裝綠色便攜包 | 291 MB | `9208ebd6e26a74167a90d6ed43c4c1bc767b264f9f85df75965932889de19e5d` |
| `thorium-browser_154.0.8023.0_AVX2.deb` | AVX2 | Debian / Ubuntu / Deepin | 217 MB | `f4856157f2f82fe9b01dd1da8ab797aa8d487451187872bc74f463a746bd75d8` |
| `thorium-browser-avx2-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX2 | Arch Linux / CachyOS / Artix | 279 MB | `612d2d4ed6138d58deadd46322f3d2dcc2d4d32029cf3df58191867e0695b682` |
| `thorium-browser-avx2-rime-bin-154.0.8023.0-portable.tar.gz` | AVX2 | 通用 Linux 免安裝綠色便攜包 | 291 MB | `dd2d45e17bfc4f1f29cf6f78dd6b2a7c6b3d7ab2e8def131b422f4fdb8d850e0` |
| `thorium-gold.png` | 通用 | 官方專屬金色圓環圖標 | 11 KB | `0ca24a89340bcbace48f6b4f4ee1f71b36777d3bd2edd06a6b6591547027d321` |
| `thorium-m154-avx512-suite.zip` | 通用 | 補丁與配置一鍵隨身包 | 32 KB | `0ecb9b8b6ff92a7e7bb60b133ba50c379a7852c00a4023b8273eaee179f8ad38` |
| `SHA256SUMS.txt` | 通用 | 官方二進制發行校驗表 | 1 KB | 完整校驗總表 |

---

### 💻 支援處理器微架構清單

- **AVX-512 版本**：
  - **Intel**：第 10 代 Core（Ice Lake）、第 11 代 Core（Tiger Lake / Rocket Lake）、Core X 系列（Skylake-X / Cascade Lake-X）、Xeon Scalable（第 1 至 5 代）。
  - **AMD**：Ryzen 7000 / 8000 / 9000 系列（Zen 4、Zen 5）、EPYC 9004 / 8004 / 9005。
- **AVX2 版本**：
  - **Intel**：第 4 代 Core（Haswell）至第 14 代 Core（Raptor Lake Refresh）、Xeon E3/E5 v3/v4 等所有具備 AVX2 指令集之處理器。
  - **AMD**：Ryzen 1000 至 5000 系列（Zen 1, Zen+, Zen 2, Zen 3）及更早之 Excavator 架構。
