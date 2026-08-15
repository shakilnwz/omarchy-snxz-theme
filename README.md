# Omarchy SNXZ Theme

A modern, high-contrast dark theme with cyan, mauve, and blue-indigo accents tailored for **Omarchy Quattro (4.0)**, featuring native Lua Hyprland configuration, Quickshell styling, Herdr multiplexer support, and custom shell plugins.

---

## 🚀 Clean Installation Flow

### 1. Install the Theme
Run the main installer script from the root of the repository:

```bash
./install.sh
```

**What this does automatically:**
- Copies helper scripts (`vnote`, `herdr-sessionizer`, `tmux-sessionizer`, `cycle-display`) to `~/.local/bin/snxz/` and makes them executable.
- Symlinks the theme directory into `~/.config/omarchy/themes/snxz`.
- Copies `herdr.toml` into `~/.config/herdr/config.toml` (with custom palette, tabs, `ctrl+a` prefix, and sessionizer integration).
- Idempotently adds `~/.local/bin/snxz` to `$PATH` and configures `Ctrl+\` shortcut in `~/.zshrc`.
- Applies the theme immediately using `omarchy theme set snxz`.

---

### 2. Install Quickshell Plugins (Optional / Standalone)
To install the custom shell plugins (Clock + compact rounded lock screen, 600px wide launcher menu, rounded volume/brightness OSD, and rounded notification toasts):

```bash
./plugins/install-plugins.sh
```

**What this does automatically:**
- Deploys **`snxz.lock`** to `~/.config/omarchy/plugins/snxz.lock` (12-hour live clock, date, `300x50` compact box, and 10px rounded corners).
- Deploys **`snxz.menu`** to `~/.config/omarchy/plugins/snxz.menu` (600px wide launcher card and rounded selection rows).
- Deploys **`snxz.osd`** to `~/.config/omarchy/plugins/snxz.osd` (Volume, brightness, and media OSD card with rounded corners and progress bar).
- Deploys **`snxz.notifications`** to `~/.config/omarchy/plugins/snxz.notifications` (Desktop notification daemon with rounded toast cards).
- Rescans and enables all 4 plugins in `omarchy-shell` and restarts the shell.
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
| `F7` | Cycle Display | Toggle multi-monitor outputs |

### Window Movement & Focus
| Shortcut / Gesture | Action |
| :--- | :--- |
| `SUPER + SHIFT + Left/Right/Up/Down` | Move active window in direction |
| `SUPER + Mouse Scroll Up/Down` | Focus left / right window |
| **3-Finger Swipe** (Left / Right / Up / Down) | Spatial window focus across windows & monitors |
| **4-Finger Horizontal Swipe** | Continuous 1:1 workspace switching |

---

## 📁 Repository Structure

```
.
├── backgrounds/                # Theme wallpaper collection
├── bin/                        # Helper scripts installed to ~/.local/bin/snxz/
│   ├── cycle-display           # Display switcher
│   ├── herdr-sessionizer       # Herdr popup switcher
│   ├── tmux-sessionizer        # Tmux session manager
│   └── vnote                   # Interactive markdown notes finder (fzf + bat)
├── colors.toml                 # Core 16-color theme palette
├── herdr.toml                  # Herdr multiplexer configuration
├── hyprland.lua                # Omarchy Quattro Hyprland Lua configuration
├── install.sh                  # Theme installation script
├── plugins/                    # Standalone Quickshell plugins
│   ├── install-plugins.sh      # Plugin installer and activator
│   ├── lock/                   # snxz.lock (Clock + compact rounded lock screen)
│   ├── menu/                   # snxz.menu (600px wide rounded launcher)
│   ├── notifications/          # snxz.notifications (Rounded notification toasts)
│   └── osd/                    # snxz.osd (Rounded volume & brightness OSD)
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
