#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] || [ ! -e "${DBUS_SESSION_BUS_ADDRESS#unix:path=}" ]; then
    DBUS_SOCK=$(ls -t /tmp/dbus-* 2>/dev/null | head -1)
    if [ -n "$DBUS_SOCK" ] && [ -S "$DBUS_SOCK" ]; then
        export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_SOCK"
    fi
fi

if [ -z "$XAUTHORITY" ] || [ ! -r "$XAUTHORITY" ]; then
    XAUTH_CANDIDATE=$(ls -t /tmp/xauth_* /var/run/sddm/xauth_* /run/xrclip/*.xauth 2>/dev/null | while read -r f; do [ -r "$f" ] && echo "$f" && break; done)
    if [ -n "$XAUTH_CANDIDATE" ]; then
        export XAUTHORITY="$XAUTH_CANDIDATE"
    fi
fi

GPU_FLAGS=""
if lspci 2>/dev/null | grep -iE "NVIDIA.*(GF108|GeForce GT|NVS|Quadro)" >/dev/null 2>&1 || [ -f /proc/driver/nvidia/version ]; then
    GPU_FLAGS="--use-gl=desktop --ignore-gpu-blocklist --enable-gpu-rasterization --enable-zero-copy --disable-features=UseSkiaGraphite,Vulkan --gpu-rasterization-msaa-sample-count=0"
fi

exec "$SCRIPT_DIR/thorium" \
  --gtk-version=3 \
  --ozone-platform=x11 \
  --enable-features=UseOzonePlatform \
  --disable-infobars \
  $GPU_FLAGS \
  "$@"
