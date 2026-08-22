# Omarchy SNXZ Theme

A modern, high-contrast dark theme with cyan, mauve, and blue-indigo accents tailored for **Omarchy Quattro (4.0)**, featuring native Lua Hyprland configuration, Quickshell styling, Herdr multiplexer support, and custom shell plugins.

---

## 🚀 Clean Installation Flow

### 1. Install the Theme
Install directly with Omarchy:

```bash
omarchy theme install git@github.com:shakilnwz/omarchy-snxz-theme.git
```

**What this does automatically:**
- Clones the theme into `~/.config/omarchy/themes/snxz`.
- Applies it with `omarchy theme set snxz`.
- Makes the theme's `bin/` helpers available to its Hyprland keybinds from `~/.local/state/omarchy/current/theme/bin/`; no separate binary installation or `$PATH` change is required.

For updates, run `omarchy theme update`, then reapply with `omarchy theme set snxz`.

`herdr.toml` is optional personal application configuration and is intentionally not installed or overwritten by the theme.

---

### 2. Install Quickshell Plugins (Optional / Standalone)
To install the custom shell plugins (Clock + compact rounded lock screen and 600px wide launcher menu):

```bash
./plugins/install-plugins.sh
```

**What this does automatically:**
- Deploys **`snxz.lock`** to `~/.config/omarchy/plugins/snxz.lock` (12-hour live clock, date, `300x50` compact box, and 10px rounded corners).
- Deploys **`snxz.menu`** to `~/.config/omarchy/plugins/snxz.menu` (600px wide launcher card and rounded selection rows).
- Rescans and enables both plugins in `omarchy-shell` and restarts the shell.
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
├── bin/                        # Helper scripts run from Omarchy's current-theme directory
│   ├── cycle-display           # Display switcher
│   ├── herdr-sessionizer       # Herdr popup switcher
│   ├── tmux-sessionizer        # Tmux session manager
│   └── vnote                   # Interactive markdown notes finder (fzf + bat)
├── colors.toml                 # Core 16-color theme palette
├── herdr.toml                  # Herdr multiplexer configuration
├── hyprland.lua                # Omarchy Quattro Hyprland Lua configuration
├── install.sh                  # Thin wrapper around `omarchy theme install` for Git checkouts
├── plugins/                    # Standalone Quickshell plugins
│   ├── install-plugins.sh      # Plugin installer and activator
│   ├── lock/                   # snxz.lock (Clock + compact rounded lock screen)
│   └── menu/                   # snxz.menu (600px wide rounded launcher)
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
