#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="snxz"
OMARCHY_USER_THEMES="$HOME/.config/omarchy/themes"
SNXZ_BIN_DIR="$HOME/.local/bin/snxz"

echo "==> Setting up Omarchy SNXZ Theme..."

# 1. Copy theme binaries to ~/.local/bin/snxz
mkdir -p "$SNXZ_BIN_DIR"
if [[ -d "$THEME_DIR/bin" ]]; then
    cp -r "$THEME_DIR/bin"/* "$SNXZ_BIN_DIR/"
    chmod +x "$SNXZ_BIN_DIR"/*
    echo "  ✓ Copied theme scripts to $SNXZ_BIN_DIR"
fi

# 2. Link theme into Omarchy user themes
mkdir -p "$OMARCHY_USER_THEMES"
ln -sfn "$THEME_DIR" "$OMARCHY_USER_THEMES/$THEME_NAME"
echo "  ✓ Linked theme to $OMARCHY_USER_THEMES/$THEME_NAME"

# 3. Copy Herdr config to ~/.config/herdr/config.toml (overwrites old config)
mkdir -p "$HOME/.config/herdr"
if [[ -f "$THEME_DIR/herdr.toml" ]]; then
    cp -f "$THEME_DIR/herdr.toml" "$HOME/.config/herdr/config.toml"
    echo "  ✓ Copied herdr.toml to ~/.config/herdr/config.toml"
fi

# 4. Ensure ~/.local/bin/snxz is in ~/.zshrc PATH
ZSHRC="$HOME/.zshrc"
PATH_LINE='export PATH="$HOME/.local/bin/snxz:$PATH"'

if [[ -f "$ZSHRC" ]]; then
    # Clean up obsolete omarchy theme bin paths if present
    if grep -q "omarchy/current/theme/bin" "$ZSHRC"; then
        sed -i '/omarchy\/current\/theme\/bin/d' "$ZSHRC"
        sed -i '/# Omarchy current theme binaries/d' "$ZSHRC"
    fi

    if ! grep -q "\.local/bin/snxz" "$ZSHRC"; then
        echo "" >> "$ZSHRC"
        echo "# SNXZ theme binaries" >> "$ZSHRC"
        echo "$PATH_LINE" >> "$ZSHRC"
        echo "  ✓ Added $SNXZ_BIN_DIR to PATH in ~/.zshrc"
    else
        echo "  ✓ SNXZ bin PATH already present in ~/.zshrc"
    fi

    # Ensure herdr-sessionizer keybinding in ~/.zshrc
    if ! grep -q "herdr-sessionizer" "$ZSHRC"; then
        echo "bindkey -s '^\' 'herdr-sessionizer\n'" >> "$ZSHRC"
        echo "  ✓ Added herdr-sessionizer keybinding (Ctrl+\\) to ~/.zshrc"
    fi
fi

# 5. Apply theme immediately if omarchy is available
if command -v omarchy-theme-set >/dev/null 2>&1; then
    echo "==> Applying theme via Omarchy..."
    omarchy theme set "$THEME_NAME" || true
    echo "  ✓ Theme '$THEME_NAME' activated!"
fi

echo ""
echo "✨ Installation complete! Restart your shell or run 'source ~/.zshrc'."

