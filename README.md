# Omarchy SNXZ Theme

A modern, high-contrast dark theme with cyan, mauve, and blue-indigo accents tailored for **Omarchy Quattro (4.0+)**, featuring custom terminal palettes, Quickshell lock/menu styling, editor color schemes, and Hyprland border accents.

---

## 🚀 Installation

### Option 1: Direct Theme Installation (Recommended)
You can install this theme directly using Omarchy's theme manager:

```bash
omarchy theme install git@github.com:shakilnwz/omarchy-snxz-theme.git
omarchy theme set snxz
```

### Option 2: Local Development Link
If you are developing or maintaining a local checkout:

```bash
# Clone the repository
git clone git@github.com:shakilnwz/omarchy-snxz-theme.git ~/code/omarchy-themes/omarchy-snxz-theme

# Link to Omarchy user themes directory
ln -nsf ~/code/omarchy-themes/omarchy-snxz-theme ~/.config/omarchy/themes/snxz

# Apply the theme
omarchy theme set snxz
```

---

## 📁 Repository Structure

```
.
├── backgrounds/                # Theme wallpaper collection
├── colors.toml                 # Core 16-color theme palette
├── hyprland.lua                # Hyprland active/inactive border & shadow colors
├── shell.toml                  # Quickshell surface, lock, and menu styling
├── preview.png                 # Theme preview screenshot
├── preview-unlock.png          # Unlock preview screenshot
├── unlock.png                  # Lock screen artwork
├── aether.zed.json             # Zed editor theme
├── neovim.lua                  # Neovim theme configuration
├── gtk.css                     # GTK theme styling
└── *.theme / *.conf / *.toml   # Terminal palettes (Ghostty, Kitty, Foot, Alacritty, Warp, Btop)
```

---

## ⚙️ Personal Workflow & Dotfiles

Personal keybindings, gestures, monitor configurations, and tool integrations (Herdr, Tmux, Vnote) are managed separately via your personal dotfiles (`~/.dotfiles`), ensuring your full workflow persists across all theme switches.
