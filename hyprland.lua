-- Omarchy SNXZ Theme — Hyprland Color & Border Styling

local active_border_color = "rgb(7186fd)"
local inactive_border_color = "rgba(00000eba)"
local active_shadow_color = "rgb(8496fd)"
local inactive_shadow_color = "rgba(00000ea6)"

hl.config({
	general = {
		col = {
			active_border = active_border_color,
			inactive_border = inactive_border_color,
		},
	},

	group = {
		col = {
			border_active = active_border_color,
			border_inactive = inactive_border_color,
		},
	},

	decoration = {
		shadow = {
			color = active_shadow_color,
			color_inactive = inactive_shadow_color,
		},
	},
})
