# Thorium AVX-512 Installation & Configuration Guide

This guide provides instructions for installing and configuring **Thorium Browser AVX-512 Edition (v151.0.7922.72)** with native RIME input method support and high-performance GPU hardware acceleration on modern Linux systems.

---

## 1. Prerequisites (AVX-512 Verification)

Ensure your CPU supports AVX-512 foundation instructions (`avx512f`):

```bash
grep -m 1 -E "(avx512f|avx512_vnni|avx512vl)" /proc/cpuinfo
```

Supported architectures include Intel 11th Gen Tiger Lake / Rocket Lake, Skylake-SP to Emerald Rapids, and AMD Zen 4 / Zen 5.

---

## 2. Installation

### Debian / Ubuntu (.deb)
```bash
sudo dpkg -i packages/thorium-browser_151.0.7922.72_AVX512_RIME.deb || sudo apt-get -f install -y
```

### Arch Linux (.pkg.tar.zst)
```bash
sudo pacman -U packages/thorium-browser-avx512-rime-bin-151.0.7922.72-1-x86_64.pkg.tar.zst
```

---

## 3. RIME Input Method (Fcitx5 / IBus) Setup

To activate native inline candidate window positioning and eliminate IME flickering:

```bash
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

thorium-browser --enable-features=UseOzonePlatform --ozone-platform=x11
```

---

## 4. Hardware Acceleration Verification

Navigate to `chrome://gpu` in Thorium and confirm:
- **Canvas**: Hardware accelerated
- **Direct Rendering**: Yes
- **Rasterization**: Hardware accelerated
- **Video Decode**: Hardware accelerated (via VA-API / NVDEC)
