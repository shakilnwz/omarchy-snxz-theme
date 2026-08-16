#!/usr/bin/env bash
set -euo pipefail

PLUGINS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.config/omarchy/plugins"

echo "==> Installing Omarchy SNXZ Quickshell Plugins..."
mkdir -p "$TARGET_DIR"

# 1. Install Lock plugin (12-hour clock, compact input, rounded corners)
if [[ -d "$PLUGINS_DIR/lock" ]]; then
    rm -rf "$TARGET_DIR/snxz.lock"
    mkdir -p "$TARGET_DIR/snxz.lock"
    cp -r "$PLUGINS_DIR/lock"/* "$TARGET_DIR/snxz.lock/"
    echo "  ✓ Installed Lock Plugin (~/.config/omarchy/plugins/snxz.lock)"
fi

# 2. Install Menu plugin (600px wide launcher card, rounded corners)
if [[ -d "$PLUGINS_DIR/menu" ]]; then
    rm -rf "$TARGET_DIR/snxz.menu"
    mkdir -p "$TARGET_DIR/snxz.menu"
    cp -r "$PLUGINS_DIR/menu"/* "$TARGET_DIR/snxz.menu/"
    echo "  ✓ Installed Wide Menu Plugin (~/.config/omarchy/plugins/snxz.menu)"
fi

# 5. Rescan and Enable in Quickshell
if command -v omarchy-shell >/dev/null 2>&1; then
    omarchy-shell shell rescanPlugins >/dev/null 2>&1 || true
fi

if command -v omarchy >/dev/null 2>&1; then
    omarchy plugin enable snxz.lock >/dev/null 2>&1 || true
    omarchy plugin enable snxz.menu >/dev/null 2>&1 || true
    omarchy restart shell >/dev/null 2>&1 || true
    echo "  ✓ Enabled all SNXZ plugins & restarted Quickshell"
fi

echo ""
echo "✨ SNXZ plugins installation complete!"
