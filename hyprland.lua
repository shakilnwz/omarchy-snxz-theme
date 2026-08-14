-- This file is the Lua configuration for Hyprland (Omarchy Quattro / Hyprland 0.55+).
-- It is intended to be included / required in your main hyprland.lua.

local activeBorderColor   = "rgb(7186fd)"
local activeShadowColor   = "rgb(8496fd)"
local inactiveBorderColor = "rgba(00000eba)"
local inactiveShadowColor = "rgba(00000ea6)"

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        col = {
            active_border   = activeBorderColor,
            inactive_border = inactiveBorderColor,
        },
        gaps_in     = 0,
        gaps_out    = 0,
        border_size = 1,
        layout      = "scrolling",
    },

    group = {
        col = {
            border_active   = activeBorderColor,
            border_inactive = inactiveBorderColor,
        },
    },

    decoration = {
        rounding = 0,

        blur = {
            enabled           = true,
            size              = 5,
            passes            = 2,
            new_optimizations = true,
            vibrancy          = 0.2,
            ignore_opacity    = false,
        },

        shadow = {
            enabled        = true,
            range          = 16,
            render_power   = 4,
            color          = activeShadowColor,
            color_inactive = inactiveShadowColor,
        },
    },

    scrolling = {
        fullscreen_on_one_column = true,
        column_width             = 1,
        focus_fit_method         = 1,
        follow_focus             = true,
        follow_min_visible       = 0.1,
    },
})

----------------------
---- WINDOW RULES ----
----------------------

-- Makes keepassxc float
hl.window_rule({
    name  = "keepass-window",
    match = { class = "org.keepassxc.KeePassXC" },
    float = true,
    pin   = true,
})

hl.window_rule({
    name        = "floating-window",
    match       = { float = true },
    border_size = 2,
    rounding    = 4,
    center      = true,
})

hl.window_rule({
    name        = "modal-window",
    match       = { modal = true },
    border_size = 2,
    rounding    = 4,
    float       = true,
    center      = true,
})


-------------------------
---- CUSTOM KEYBINDS ----
-------------------------

hl.bind("SUPER + ALT + Return", "exec, uwsm-app -- xdg-terminal-exec --dir=\"$(omarchy-cmd-terminal-cwd)\" zsh -c \"herdr\"", { description = "Herdr" })
hl.bind("SUPER + SHIFT + D", "exec, omarchy-launch-tui lazydocker", { description = "Docker" })
hl.bind("SUPER + SHIFT + ALT + O", "exec, omarchy-launch-or-focus ^obsidian$ \"uwsm-app -- obsidian\"", { description = "Obsidian" })
hl.bind("SUPER + SHIFT + O", "exec, uwsm-app -- xdg-terminal-exec zsh -c ~/.config/omarchy/current/theme/bin/vnote", { description = "Vnote" })
hl.bind("SUPER + SHIFT + slash", "exec, uwsm-app -- KeePassXC", { description = "Passwords" })
hl.bind("SUPER + backslash", "exec, uwsm-app -- xdg-terminal-exec zsh -c ~/.config/omarchy/current/theme/bin/herdr-sessionizer", { description = "Herdr" })
hl.bind("SUPER + SHIFT + backslash", "exec, uwsm-app -- xdg-terminal-exec zsh -c ~/.config/omarchy/current/theme/bin/tmux-sessionizer", { description = "Tmux" })
hl.bind("F7", "exec, ~/.config/omarchy/current/theme/bin/cycle-display", { description = "Cycle display" })

-- Move active window with SUPER + SHIFT + arrow keys
hl.bind("SUPER + SHIFT + Left", "movewindow, l", { description = "Move window left" })
hl.bind("SUPER + SHIFT + Right", "movewindow, r", { description = "Move window right" })
hl.bind("SUPER + SHIFT + Up", "movewindow, u", { description = "Move window up" })
hl.bind("SUPER + SHIFT + Down", "movewindow, d", { description = "Move window down" })

-- Move focus with SUPER + mouse scroll wheel
hl.bind("SUPER + mouse_up", "movefocus, l", { description = "Focus left window" })
hl.bind("SUPER + mouse_down", "movefocus, r", { description = "Focus right window" })


------------------
---- GESTURES ----
------------------

-- 3-finger swipe to move focus between windows (workspace-agnostic & monitor-aware, natural scrolling)
hl.gesture({ fingers = 3, direction = "left",  action = "dispatcher, movefocus, r" })
hl.gesture({ fingers = 3, direction = "right", action = "dispatcher, movefocus, l" })
hl.gesture({ fingers = 3, direction = "up",    action = "dispatcher, movefocus, u" })
hl.gesture({ fingers = 3, direction = "down",  action = "dispatcher, movefocus, d" })

-- 4-finger horizontal swipe to switch workspaces
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })

-----------------------
---- MONITOR SETUP ----
-----------------------

-- External 1920x1080 display (HDMI-A-2) on top of the laptop display (60Hz, 1x scale)
hl.monitor({
    output   = "HDMI-A-2",
    mode     = "1920x1080@60",
    position = "auto-up",
    scale    = 1,
})

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "auto",
    scale    = 1,
})
