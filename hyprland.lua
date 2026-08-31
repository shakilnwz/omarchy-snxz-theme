-- Omarchy SNXZ Theme — Hyprland Color & Border Styling

local active_border_color = "rgb(7186fd)"
local inactive_border_color = "rgba(00000eba)"

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
})
