require("events")
local wezterm = require("wezterm")
local colorschemeSetter = require("colors")
local keysSetter = require("keymaps")

M = {}

M.colorscheme = "Tokyo Night Moon"

M.background = "#090909"
-- M.background = "#111111"
-- M.background = "#070707"
-- M.background = "#000000"
-- M.background = "#0c0c15"
-- M.background = "#11111b"
-- M.background = "#001122"

M.font = { family = "Hack Nerd Font", weight = 400, font_size = 13.2, line_height = 1.40 }
M.font = { family = "BerkeleyMono Nerd Font", weight = 400, font_size = 13.2, line_height = 1.30 }

M.opacity = 0.9

local config = {
	-- default_domain = "WSL:Ubuntu-22.04",
	-- default_prog = { "pwsh.exe", "-nologo" },
	color_scheme_dirs = { "C:\\Users\\Andrew\\.config\\wezterm\\colors" },
	default_prog = { "C:\\Program Files\\nu\\bin\\nu.exe" },
	font = wezterm.font(M.font.family, { weight = M.font.weight }),
	font_rules = {
		{ intensity = "Bold", font = wezterm.font(M.font.family, { weight = M.font.weight }) },
		{ intensity = "Normal", font = wezterm.font(M.font.family, { weight = M.font.weight, italic = false }) },
	},
	font_size = M.font.font_size,
	line_height = M.font.line_height,
	window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	},
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = M.opacity,
	enable_tab_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	tab_max_width = 9999,
	adjust_window_size_when_changing_font_size = false,
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	hide_mouse_cursor_when_typing = true,
	animation_fps = 60,
	enable_scroll_bar = false,
	initial_cols = 90,
	initial_rows = 30,
}

colorschemeSetter(config)
keysSetter(config)

return config
