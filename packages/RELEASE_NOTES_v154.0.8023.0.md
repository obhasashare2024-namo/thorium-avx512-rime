# Thorium Browser v154.0.8023.0 (AVX-512 & RIME 旗舰版)

次世代 **Chromium 154（154.0.8023.0）** 核心引擎與 **Thorium 152** 極致效能架構之旗艦發行版本，針對現代 **AVX-512（Skylake-X / Ice Lake / Zen 4 / Zen 5）** 處理器進行 512 位元原生硬體向量加速優化。

> [!TIP]
> **尋找 AVX2 版本？**：若您的 CPU 不支援 AVX-512（例如 Intel 4代至14代無 AVX-512 處理器、Xeon E3/E5 v3/v4 或 AMD Zen 1-3），請至獨立專屬倉庫下載：[Thorium AVX2 專屬倉庫](https://github.com/obhasashare2024-namo/thorium-avx2-rime)。

---

### 🚀 核心升級與重大改進

1. **AVX-512 旗艦微架構原生支援**
   - 鎖定 `skylake-avx512`（AVX-512F, AVX-512BW, AVX-512CD, AVX-512DQ, AVX-512VL），釋放 32 個 512 位元 ZMM 向量暫存器極致效能。
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

5. **深紫色閃電 Logo、原子核原子圖標與進程名硬化**
   - 全面替換為使用者核准之深紫色閃電視覺標識（`thorium-purple-lightning.png` 與全套 16x16 至 512x512 桌面圖標），與系統各版本物理隔離。
   - 二進制命名與內核 `/proc/$PID/comm` 雙重硬化為 `thorium`，徹底杜絕單例鎖爭用。

---

### 📦 發行套件與 SHA-256 校驗總表

| 附件檔案 | 微架構 | 適用系統 | 檔案大小 | SHA-256 校驗碼 |
| :--- | :--- | :--- | :--- | :--- |
| `thorium-browser_154.0.8023.0_AVX512.deb` | AVX-512 | Debian / Ubuntu / Deepin | 217 MB | `acc80ba2383cc2f86df2c4de31d4ac491547c58dffbebd5fad32bcbf17aac6b1` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-1-x86_64.pkg.tar.zst` | AVX-512 | Arch Linux / CachyOS / Artix | 279 MB | `07471efb1f614c552f7e2d4c52a3b6c3c8b44fdae014cc5e82b954d9a68874bb` |
| `thorium-browser-avx512-rime-bin-154.0.8023.0-portable.tar.gz` | AVX-512 | 通用 Linux 免安裝綠色便攜包 | 291 MB | `975843f28449eddc64f65bd2180c816fded905c07b25c3c09c46a007c0276fa5` |
| `thorium-m154-avx512-suite.zip` | 通用 | 補丁與配置一鍵隨身包 | 32 KB | `0af3f790cae9097205be546f187ddf6b23c07d0dd33f1260db6f2192c4e0d246` |
| `thorium-purple-lightning.png` | 通用 | 官方深紫色閃電發行圖標 | 106 KB | `1f248d1baacb26d0ba769d90116bd7784b8c3ac8e5f823fb25634f3778968d53` |
| `SHA256SUMS.txt` | 通用 | 官方二進制發行校驗表 | 1 KB | 完整校驗總表 |

---

### 💻 支援處理器微架構清單

- **Intel**：第 10 代 Core（Ice Lake）、第 11 代 Core（Tiger Lake / Rocket Lake）、Core X 系列（Skylake-X / Cascade Lake-X）、Xeon Scalable（第 1 至 5 代）。
- **AMD**：Ryzen 7000 / 8000 / 9000 系列（Zen 4、Zen 5）、EPYC 9004 / 8004 / 9005。
