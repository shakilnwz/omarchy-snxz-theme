#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="snxz"
OMARCHY_USER_THEMES="$HOME/.config/omarchy/themes"

echo "==> Setting up Omarchy SNXZ Theme..."

# 1. Ensure theme binaries are executable
if [[ -d "$THEME_DIR/bin" ]]; then
    chmod +x "$THEME_DIR/bin"/*
    echo "  ✓ Made theme scripts in bin/ executable"
fi

# 2. Link theme into Omarchy user themes
mkdir -p "$OMARCHY_USER_THEMES"
ln -sfn "$THEME_DIR" "$OMARCHY_USER_THEMES/$THEME_NAME"
echo "  ✓ Linked theme to $OMARCHY_USER_THEMES/$THEME_NAME"

# 3. Ensure theme bin PATH is in ~/.zshrc
ZSHRC="$HOME/.zshrc"
PATH_LINE='export PATH="$HOME/.config/omarchy/current/theme/bin:$PATH"'
if [[ -f "$ZSHRC" ]]; then
    if ! grep -q "omarchy/current/theme/bin" "$ZSHRC"; then
        echo "" >> "$ZSHRC"
        echo "# Omarchy current theme binaries" >> "$ZSHRC"
        echo "$PATH_LINE" >> "$ZSHRC"
        echo "  ✓ Added theme bin PATH to ~/.zshrc"
    else
        echo "  ✓ Theme bin PATH already present in ~/.zshrc"
    fi

    # Ensure herdr-sessionizer keybinding in ~/.zshrc
    if ! grep -q "herdr-sessionizer" "$ZSHRC"; then
        echo "bindkey -s '^\' 'herdr-sessionizer\n'" >> "$ZSHRC"
        echo "  ✓ Added herdr-sessionizer keybinding (Ctrl+\\) to ~/.zshrc"
    fi
fi

# 4. Apply theme immediately if omarchy is available
if command -v omarchy-theme-set >/dev/null 2>&1; then
    echo "==> Applying theme via Omarchy..."
    omarchy theme set "$THEME_NAME" || true
    echo "  ✓ Theme '$THEME_NAME' activated!"
fi

echo ""
echo "✨ Installation complete! Restart your shell or run 'source ~/.zshrc'."
