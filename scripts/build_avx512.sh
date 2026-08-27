#!/usr/bin/env bash
# ==============================================================================
# Thorium Browser 151 (Skylake-AVX512) Automated Build Pipeline
# Architecture: Skylake-AVX512 (512-bit ZMM SIMD Vectorization)
# ==============================================================================
set -euo pipefail

WORKSPACE_ROOT="${1:-/workspace/chromium/src}"
OUT_DIR="${WORKSPACE_ROOT}/out/thorium_avx512"

echo "=== [1/4] Checking GN and Ninja environment ==="
export PATH="${WORKSPACE_ROOT}/third_party/ninja:/workspace/depot_tools:${PATH}"
export DEPOT_TOOLS_UPDATE=0

echo "=== [2/4] Setting up GN build arguments ==="
mkdir -p "${OUT_DIR}"
cp -f "$(dirname "$0")/../config/args_avx512.gn" "${OUT_DIR}/args.gn"

echo "=== [3/4] Generating Ninja build graph ==="
gn gen "${OUT_DIR}"

echo "=== [4/4] Starting compilation ==="
ninja -C "${OUT_DIR}" -j"$(nproc)" chrome chrome_crashpad_handler

echo "=== Build Completed Successfully! ==="
ls -lh "${OUT_DIR}/chrome" "${OUT_DIR}/chrome_crashpad_handler"
