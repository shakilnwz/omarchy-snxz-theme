return {
	{
		"bjarneo/aether.nvim",
		branch = "v3",
		name = "aether",
		priority = 1000,
		opts = {
			transparent = true,
			colors = {
				bg = "#00000e",
				dark_bg = "#00000b",
				darker_bg = "#000007",
				lighter_bg = "#31314e",

				fg = "#c7efe3",
				dark_fg = "#95b3aa",
				light_fg = "#cff1e7",
				bright_fg = "#d5f3ea",
				muted = "#5f6167",

				red = "#ff4d6d",
				yellow = "#ffd166",
				orange = "#ff6883",
				green = "#00d4a8",
				cyan = "#00cfe8",
				blue = "#7186fd",
				purple = "#b388ff",
				brown = "#993e4f",

				bright_red = "#ff6f8f",
				bright_yellow = "#ffe085",
				bright_green = "#33f0c0",
				bright_cyan = "#3aeaff",
				bright_blue = "#5cb7ff",
				bright_purple = "#c7a6ff",

				accent = "#7186fd",
				cursor = "#c7efe3",
				foreground = "#c7efe3",
				background = "#00000e",
				selection = "#31314e",
				selection_foreground = "#c7efe3",
				selection_background = "#31314e",
			},
		},
		-- set up hot reload
		config = function(_, opts)
			require("aether").setup(opts)
			vim.cmd.colorscheme("aether")
			require("aether.hotreload").setup()
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "aether",
		},
	},
}
