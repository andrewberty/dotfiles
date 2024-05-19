require("events")
local wezterm = require("wezterm")
local colors = require("colors")
local keymaps = require("keymaps")
local tabbar = require("tabbar")

Global = {
	-- background = "#0c0c15",
	-- background = "#11111b",
	-- background = "#001122",
	background = "#000000",

	font = { family = "Hack", weight = 400, font_size = 17.2, line_height = 1.40 },
	-- font = { family = "BerkeleyMono Nerd Font", weight = 400, font_size = 18, line_height = 1.30 },

	enable_tab_bar = false,
	colorscheme = "rose-pine-moon",
	opacity = 0.9,
}

local config = {
	-- FONT
	font = wezterm.font(Global.font.family, { weight = Global.font.weight }),
	font_rules = {
		{ intensity = "Bold", font = wezterm.font(Global.font.family, { weight = Global.font.weight }) },
		{
			intensity = "Normal",
			font = wezterm.font(Global.font.family, { weight = Global.font.weight, italic = false }),
		},
	},
	font_size = Global.font.font_size,
	line_height = Global.font.line_height,

	-- WINDOW
	window_padding = {
		top = 20,
		bottom = 20,
		left = 20,
		right = 20,
	},
	window_close_confirmation = "NeverPrompt",
	macos_window_background_blur = 50,
	window_background_opacity = Global.opacity,
	window_decorations = "RESIZE",
	adjust_window_size_when_changing_font_size = false,
	initial_cols = 90,
	initial_rows = 30,
	enable_scroll_bar = false,

	-- CURSOR
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	hide_mouse_cursor_when_typing = true,
	animation_fps = 60,
}

colors.setup(config)
keymaps.setup(config)
tabbar.setup(config)

return config
