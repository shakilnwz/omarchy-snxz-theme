# Omarchy SNXZ Theme

A modern, high-contrast dark theme with cyan, mauve, and blue-indigo accents tailored for **Omarchy Quattro (4.0)**, featuring native Lua Hyprland configuration, Quickshell styling, Herdr multiplexer support, and custom shell plugins.

---

## 🚀 Clean Installation Flow

### 1. Install the Theme

> **Requires Omarchy Quattro (4.0.1+).** Since 4.0.1, themes cloned by `omarchy theme install <url>` are staged *without* their `.lua` or terminal configs — those run code at login, so repo-installed themes are restricted to colors only. Because this theme's native Hyprland configuration is its centerpiece, install it as your own working copy instead: Omarchy explicitly trusts a symlink to a checkout you maintain and stages it verbatim.

Clone the repository anywhere you keep code, then run the installer from the checkout:

```bash
git clone git@github.com:shakilnwz/omarchy-snxz-theme.git ~/code/omarchy-themes/omarchy-snxz-theme
~/code/omarchy-themes/omarchy-snxz-theme/install.sh
```

**What this does automatically:**
- Symlinks the checkout to `~/.config/omarchy/themes/snxz` (refuses to touch an existing real directory there).
- Applies the theme with `omarchy theme set snxz`, staging the full configuration: Hyprland Lua (layout, keybinds, gestures, monitor setup), terminal palettes, editor/app theming, and shell styling.
- Puts the theme's `bin/` helpers under `~/.local/bin/snxz/` as symlinks to the checkout — Hyprland keybinds call them there, interactive shells reach them once `$HOME/.local/bin/snxz` is on `$PATH`. Nothing outside that directory is touched.

To apply changes made in the checkout, re-run `omarchy theme set snxz`. To update, `git pull` inside the checkout, then run the same command.

<details>
<summary>Low-trust alternative</summary>

```bash
omarchy theme install git@github.com:shakilnwz/omarchy-snxz-theme.git
```

Still works for color-only styling of supported apps, but Omarchy will strip the Hyprland Lua, Neovim config, and terminal configs from this install.

</details>

`herdr.toml` is optional personal application configuration and is intentionally not installed or overwritten by the theme.

---

### 2. Install Quickshell Plugins (Optional / Standalone)
To install the custom shell plugins (Clock + compact rounded lock screen, 600px wide launcher menu, and Waybar-style taskbar):

```bash
./plugins/install-plugins.sh
```

**What this does automatically:**
- Deploys **`snxz.lock`** to `~/.config/omarchy/plugins/snxz.lock` (12-hour live clock, date, `300x50` compact box, and 10px rounded corners).
- Deploys **`snxz.menu`** to `~/.config/omarchy/plugins/snxz.menu` (600px wide launcher card and rounded selection rows).
- Deploys **`snxz.taskbar`** to `~/.config/omarchy/plugins/snxz.taskbar` (Waybar-style open-window icons in the bar's left section).
- Rescans and enables all three plugins in `omarchy-shell` and restarts the shell.
- *Note:* Because these are global user plugins, their structural features persist across all themes while adapting to each theme's active color palette.

---

## ⌨️ Keybindings & Navigation

### Custom App & Session Keybinds
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `SUPER + ALT + Return` | Launch Herdr | Opens terminal in cwd inside Herdr |
| `SUPER + \` | Herdr Sessionizer | Popup workspace/session picker |
| `SUPER + SHIFT + \` | Tmux Sessionizer | Tmux session manager popup |
| `SUPER + SHIFT + O` | Vnote | Interactive `fzf` markdown note taker |
| `SUPER + SHIFT + /` | KeePassXC | Password manager |
| `SUPER + SHIFT + D` | Lazydocker | Docker TUI manager |
| Display key (no Fn) | Cycle Display | Toggle multi-monitor outputs |

### Window Management & Focus
| Shortcut / Gesture | Action |
| :--- | :--- |
| `SUPER + Q` | Close active window |
| `SUPER + SHIFT + Left/Right/Up/Down` | Move active window in direction |
| `SUPER + Mouse Scroll Up/Down` | Focus left / right window |
| **3-Finger Swipe** (Left / Right / Up / Down) | Spatial window focus across windows & monitors |
| **4-Finger Horizontal Swipe** | Continuous 1:1 workspace switching |

---

## 📁 Repository Structure

```
.
├── backgrounds/                # Theme wallpaper collection
├── bin/                        # Helper scripts linked onto $PATH by install.sh
│   ├── cycle-display           # Display switcher
│   ├── herdr-sessionizer       # Herdr popup switcher
│   ├── tmux-sessionizer        # Tmux session manager
│   └── vnote                   # Interactive markdown notes finder (fzf + bat)
├── colors.toml                 # Core 16-color theme palette
├── herdr.toml                  # Herdr multiplexer configuration
├── hyprland.lua                # Omarchy Quattro Hyprland Lua configuration
├── install.sh                  # Links this checkout into ~/.config/omarchy/themes/snxz and applies it
├── plugins/                    # Standalone Quickshell plugins
│   ├── install-plugins.sh      # Plugin installer and activator
│   ├── lock/                   # snxz.lock (Clock + compact rounded lock screen)
│   ├── menu/                   # snxz.menu (600px wide rounded launcher)
│   └── taskbar/                # snxz.taskbar (Waybar-style open window icons)
├── preview.png                 # Theme preview screenshot
├── shell.toml                  # Quickshell surface, lock, and menu styling
└── *.theme / *.conf / *.json   # Terminal, editor, and app color definitions
```

---

## 🔍 Validation & Testing Commands

- **Verify Hyprland Configuration**:
  ```bash
  hyprctl reload && hyprctl configerrors
  ```
- **Preview Lock Screen**:
  ```bash
  omarchy-shell lock preview
  ```
- **Check Active Quickshell Plugins**:
  ```bash
  omarchy plugin list
  ```
- **Reload Herdr Multiplexer Config**:
  ```bash
  herdr server reload-config
  ```
