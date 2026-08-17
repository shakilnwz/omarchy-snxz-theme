-- This file is the Lua configuration for Hyprland (Omarchy Quattro / Hyprland 0.55+).
-- It is intended to be included / required in your main hyprland.lua.

local activeBorderColor = "rgb(7186fd)"
local activeShadowColor = "rgb(8496fd)"
local inactiveBorderColor = "rgba(00000eba)"
local inactiveShadowColor = "rgba(00000ea6)"

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	cursor = {
		no_warps = true,
		warp_on_change_workspace = 0,
	},

	general = {
		col = {
			active_border = activeBorderColor,
			inactive_border = inactiveBorderColor,
		},
		gaps_in = 0,
		gaps_out = 0,
		border_size = 1,
		layout = "scrolling",
	},

	group = {
		col = {
			border_active = activeBorderColor,
			border_inactive = inactiveBorderColor,
		},
	},

	decoration = {
		rounding = 10,

		blur = {
			enabled = true,
			size = 5,
			passes = 2,
			new_optimizations = true,
			vibrancy = 0.2,
			ignore_opacity = false,
		},

		shadow = {
			enabled = true,
			range = 16,
			render_power = 4,
			color = activeShadowColor,
			color_inactive = inactiveShadowColor,
		},
	},

	scrolling = {
		fullscreen_on_one_column = true,
		column_width = 1,
		focus_fit_method = 1,
		follow_focus = true,
		follow_min_visible = 0.1,
	},
})

----------------------
---- WINDOW RULES ----
----------------------

-- Makes keepassxc float
hl.window_rule({
	name = "keepass-window",
	match = { class = "org.keepassxc.KeePassXC" },
	float = true,
	pin = true,
})

hl.window_rule({
	name = "floating-window",
	match = { float = true },
	border_size = 2,
	rounding = 4,
	center = true,
})

hl.window_rule({
	name = "modal-window",
	match = { modal = true },
	border_size = 2,
	rounding = 4,
	float = true,
	center = true,
})

hl.window_rule({
	name = "tiled-window",
	match = { float = false },
	rounding = 0,
})
-------------------------
---- CUSTOM KEYBINDS ----
-------------------------

hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close active window" })
hl.bind(
	"SUPER + ALT + Return",
	hl.dsp.exec_cmd('uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" zsh -c "herdr"'),
	{ description = "Herdr" }
)
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("omarchy-launch-tui lazydocker"), { description = "Docker" })
hl.bind(
	"SUPER + SHIFT + ALT + O",
	hl.dsp.exec_cmd('omarchy-launch-or-focus ^obsidian$ "uwsm-app -- obsidian"'),
	{ description = "Obsidian" }
)
hl.bind(
	"SUPER + SHIFT + O",
	hl.dsp.exec_cmd("uwsm-app -- xdg-terminal-exec zsh -c ~/.local/bin/snxz/vnote"),
	{ description = "Vnote" }
)
hl.bind("SUPER + SHIFT + slash", hl.dsp.exec_cmd("uwsm-app -- KeePassXC"), { description = "Passwords" })
hl.bind(
	"SUPER + backslash",
	hl.dsp.exec_cmd("uwsm-app -- xdg-terminal-exec zsh -c ~/.local/bin/snxz/herdr-sessionizer"),
	{ description = "Herdr" }
)
hl.bind(
	"SUPER + ALT + backslash",
	hl.dsp.exec_cmd("uwsm-app -- xdg-terminal-exec zsh -c '~/.local/bin/snxz/herdr-sessionizer --dual'"),
	{ description = "Herdr Dual" }
)
hl.bind(
	"SUPER + SHIFT + backslash",
	hl.dsp.exec_cmd("uwsm-app -- xdg-terminal-exec zsh -c ~/.local/bin/snxz/tmux-sessionizer"),
	{ description = "Tmux" }
)
hl.bind("F7", hl.dsp.exec_cmd("~/.local/bin/snxz/cycle-display"), { description = "Cycle display" })

-- Move active window with SUPER + SHIFT + arrow keys
hl.bind("SUPER + SHIFT + Left", hl.dsp.window.move({ direction = "left" }), { description = "Move window left" })
hl.bind("SUPER + SHIFT + Right", hl.dsp.window.move({ direction = "right" }), { description = "Move window right" })
hl.bind("SUPER + SHIFT + Up", hl.dsp.window.move({ direction = "up" }), { description = "Move window up" })
hl.bind("SUPER + SHIFT + Down", hl.dsp.window.move({ direction = "down" }), { description = "Move window down" })

-- Helper to perform spatial focus movement but strictly constrained to the active monitor
local function constrain_focus(dir, rev_dir)
	local cur_mon = hl.get_active_monitor().id
	hl.dispatch(hl.dsp.focus({ direction = dir }))
	local new_mon = hl.get_active_monitor().id

	if cur_mon ~= new_mon then
		hl.dispatch(hl.dsp.focus({ direction = rev_dir }))
	end
end

hl.bind("SUPER + mouse_up", function()
	constrain_focus("left", "right")
end, { description = "Focus left (constrained)" })
hl.bind("SUPER + mouse_down", function()
	constrain_focus("right", "left")
end, { description = "Focus right (constrained)" })

------------------
---- GESTURES ----
------------------

-- 3-finger swipe to move focus between windows (workspace-agnostic & monitor-aware, natural scrolling)

hl.gesture({
	fingers = 3,
	direction = "left",
	action = function()
		constrain_focus("right", "left")
	end,
})

hl.gesture({
	fingers = 3,
	direction = "right",
	action = function()
		constrain_focus("left", "right")
	end,
})

hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.dispatch(hl.dsp.focus({ direction = "up" }))
	end,
})

hl.gesture({
	fingers = 3,
	direction = "down",
	action = function()
		hl.dispatch(hl.dsp.focus({ direction = "down" }))
	end,
})

hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})

-----------------------
---- MONITOR SETUP ----
-----------------------

-- External 1920x1080 display (HDMI-A-2) on top of the laptop display (60Hz, 1x scale)
hl.monitor({
	output = "HDMI-A-2",
	mode = "1920x1080@60",
	position = "auto-up",
	scale = 1,
})

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "auto",
	scale = 1,
})

-- Input config
hl.config({
	input = {
		-- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt.
		-- kb_layout = "us,dk,eu",
		-- kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",

		-- Use a specific keyboard variant if needed (e.g. intl for international keyboards).
		-- kb_variant = "intl",

		-- Change speed of keyboard repeat.
		repeat_rate = 50,
		repeat_delay = 200,

		-- Start with numlock on by default.
		-- numlock_by_default = true,

		-- Increase sensitivity for mouse/trackpad (default: 0).
		sensitivity = 1,

		-- Turn off mouse acceleration (default: adaptive).
		-- accel_profile = "flat",

		touchpad = {
			-- Use natural (inverse) scrolling.
			natural_scroll = true,

			-- Use two-finger clicks for right-click instead of lower-right corner.
			clickfinger_behavior = false,
			-- Control the speed of your scrolling.
			scroll_factor = 1.5,

			-- Enable the touchpad while typing.
			disable_while_typing = true,

			-- Left-click-and-drag with three fingers.
			-- drag_3fg = 1,
		},
	},
})
