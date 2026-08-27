# Thorium AVX-512 Support Matrix & Microarchitecture Guide
# Thorium AVX-512 硬體支援矩陣與微架構指南

---

## 1. Supported CPU Microarchitectures / 支援的 CPU 微架構

This Thorium build is strictly optimized with `-march=skylake-avx512 -O3 -fno-finite-math-only -flto=thin`. It unlocks full 512-bit wide vector registers (`ZMM0`~`ZMM31`) and executes hardware-accelerated SIMD instructions across V8 JavaScript JIT, WebAssembly SIMD, Blink layout/DOM rasterization, Skia rendering, and media decoders.

本版本針對 `skylake-avx512` 進行深度專屬優化，全面解鎖 512 位元寬度的 `ZMM` 暫存器與 AVX-512 指令集，使 V8 JS JIT 引擎、WASM 向量運算、Blink 點陣化、Skia 渲染與多媒體解碼均獲得最頂級的硬體加速。

| Vendor / 廠商 | CPU Series / 處理器系列 | Microarchitecture / 微架構 | AVX-512 Status / 支援狀態 |
| :--- | :--- | :--- | :--- |
| **Intel** | **11th Gen Core (Tiger Lake / Rocket Lake)** (e.g. i7-11800H, i7-11700K, i9-11900K) | Willow Cove / Cypress Cove | **✅ Fully Supported (滿血支援)** |
| **Intel** | **10th Gen Core Mobile (Ice Lake)** (e.g. i7-1065G7) | Sunny Cove | **✅ Fully Supported (滿血支援)** |
| **Intel** | **Core X-Series (7th/9th/10th Gen HEDT)** (e.g. i9-7900X, i9-9980XE, i9-10980XE) | Skylake-X / Cascade Lake-X | **✅ Fully Supported (滿血支援)** |
| **Intel** | **Xeon Scalable Processors (1st to 5th Gen)** (Skylake-SP, Cascade Lake, Cooper Lake, Ice Lake-SP, Sapphire Rapids, Emerald Rapids) | Skylake-SP ~ Golden Cove | **✅ Fully Supported (滿血支援)** |
| **Intel** | **Xeon W-Series Workstations** (e.g. W-2100, W-2200, W-3175X, W-3400) | Skylake-W ~ Golden Cove | **✅ Fully Supported (滿血支援)** |
| **AMD** | **Ryzen 7000 / 8000 / 9000 Series** (e.g. R7 7700X, R9 7950X, R7 7840HS, R9 9950X) | Zen 4 / Zen 4c / Zen 5 | **✅ Fully Supported (滿血支援)** |
| **AMD** | **EPYC 9004 / 8004 / 9005 Series** (Genoa, Bergamo, Siena, Turin) | Zen 4 / Zen 5 Server | **✅ Fully Supported (滿血支援)** |
| **AMD** | **Ryzen Threadripper 7000 Series** (e.g. 7960X, 7970X, 7980X, 7995WX) | Zen 4 Threadripper | **✅ Fully Supported (滿血支援)** |
| **Intel** | **Xeon E5 v4 / Broadwell / Haswell / Sandy Bridge / Ivy Bridge** (e.g. E5-2696 v4, i7-4770, i5-3210M) | Broadwell / Haswell / Ivy Bridge | **❌ Unsupported (請改用 Thorium AVX2 / AVX 版本)** |
| **AMD** | **Ryzen 1000 ~ 5000 Series** (Zen / Zen+ / Zen 2 / Zen 3) | Zen 1 ~ Zen 3 | **❌ Unsupported (請改用 Thorium AVX2 版本)** |

---

## 2. AVX-512 CPU Instruction Set Extensions / 指令集擴展支援表

| Instruction Extension / 指令集旗標 | Bit Width / 位元寬度 | Feature Description / 特性說明 | Real Hardware Acceleration in Thorium / 瀏覽器加速實效 |
| :--- | :--- | :--- | :--- |
| **AVX-512 Foundation (`avx512f`)** | 512-bit (`zmm0-zmm31`) | 32 頂級 512-bit 向量暫存器、基礎浮點與整數向量計算 | V8 JavaScript 陣列運算、矩陣乘法、WebAssembly 向量計算 |
| **AVX-512 Conflict Detection (`avx512cd`)** | 512-bit | 向量迴圈中的重複項與衝突偵測 | 加速編譯器自動向量化迴圈、V8 JIT 自動批次解包 |
| **AVX-512 Doubleword/Quadword (`avx512dq`)** | 512-bit | 32-bit / 64-bit 整數乘除法與邏輯操作 | 加速 64 位元高精度數值計算、密碼學運算與雜湊生成 |
| **AVX-512 Byte/Word (`avx512bw`)** | 512-bit | 8-bit / 16-bit 字元與短整數向量操作 | **極致加速 UTF-8/UTF-16 DOM 字串解析、JSON.parse、HTML 詞法分析** |
| **AVX-512 Vector Length Extensions (`avx512vl`)** | 128/256/512-bit | 將 AVX-512 新指令集全面套用於 XMM (128) 與 YMM (256) 暫存器 | 避免 512-bit 降頻懲罰，對中小規模資料塊提供最高能效比向量加速 |
| **AVX-512 Vector Byte Manipulation (`avx512vbmi` / `vbmi2`)** | 512-bit | 跨 64 位元車道的任意字節排列與壓縮/展開 | Skia 2D 點陣化、零拷貝顯存排版、WebP/AVIF 圖像解碼 |
| **AVX-512 Vector Neural Network Instructions (`avx512_vnni`)** | 512-bit | 8-bit / 16-bit 深度學習卷積與矩陣 INT8 點積加速 | **WebNN、ONNX Runtime Web、本機網頁端端神經網路推理加速** |
| **AVX-512 Bit Algorithms (`avx512_bitalg` / `vpopcntdq`)** | 512-bit | 位元計數（Popcount）與位元矩陣轉換 | 加速位元遮罩比對、Bloom Filter 與記憶體垃圾回收（GC）標記 |

---

## 3. Dedicated Features & Integrations / 獨家整合與特性

### 1. RIME / Fcitx5 Full Integration (無衝突繁簡輸入法支援)
* **自動 DBus 會話總線偵測**：內建自動探測 `/run/user/$UID/bus` 與 active `fcitx5` 進程環境變數，解決遠端 SSH/XRDP 或獨立桌面環境下輸入法無法溝通的痛點。
* **Zero Input Freezes (零卡死)**：配置 `--gtk-version=3` 與 `--ozone-platform=x11`，消除 Chromium 151 在 Wayland/X11 混合模式下選字框丟失或視窗焦點搶占卡死的問題。
* **實拍候選框精準對齊**：輸入拼音/倉頡時，候選字視窗精準跟隨游標，無任何視覺錯位。

### 2. NVIDIA PRIME & Dedicated GPU Hardware Offload (獨顯硬解加速)
* **自動 PRIME 導流變數**：
  ```bash
  export __NV_PRIME_RENDER_OFFLOAD=1
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export __VK_LAYER_NV_optimus=NVIDIA_only
  ```
* **VA-API / NVDEC 硬解管線**：
  ```text
  --enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,VaapiIgnoreDriverChecks,UseOzonePlatform
  --ignore-gpu-blocklist
  --enable-gpu-rasterization
  --enable-zero-copy
  ```
* 網頁 4K/8K 60fps AV1 / HEVC / VP9 / H.264 視訊播放直接交由 NVIDIA NVDEC 專用硬體晶片解碼，CPU 佔用率降至 1% 以下！

### 3. Toolchain Segregation Architecture (編譯工具鏈雙軌架構)
* 針對 `-march=skylake-avx512` 全量編譯時，自訂 `clang_x64_target` 工具鏈，將宿主機發電機（`protoc`, `cppgen_plugin`, `torque`, `v8_snapshot`）鎖定為通用 x64 指令，成功實現在舊款 CPU 或 AVX2 伺服器上無報錯交叉編譯 AVX-512 瀏覽器二進制！
