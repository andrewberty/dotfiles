local wezterm = require("wezterm")
local colorschemeSetter = require("colors")
local keysSetter = require("keymaps")

-- sed command to update whatever inside "" in line contains Colorscheme
-- sed -i '/Colorscheme/s/".*"/"color"/' wezterm.lua
Colorscheme = "catppuccin-mocha"
Background = "#11111b"
Font = "BerkeleyMono Nerd Font"

local config = {
	-- default_prog = { "pwsh.exe", "-nologo" },
	default_domain = "WSL:Ubuntu-22.04",
	font = wezterm.font(Font, { weight = 400 }),
	font_rules = { { intensity = "Bold", font = wezterm.font(Font, { weight = 400 }) } },
	font_size = 13.5,
	line_height = 1.2,
	window_padding = {
		top = 10,
		bottom = 10,
		left = 10,
		right = 10,
	},
	window_close_confirmation = "NeverPrompt",
	-- enable_tab_bar = false,
	-- show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	window_decorations = "RESIZE",
	tab_max_width = 100,
	adjust_window_size_when_changing_font_size = false,
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	front_end = "OpenGL",
	hide_mouse_cursor_when_typing = false,
	animation_fps = 60,
	enable_scroll_bar = false,
	initial_cols = 128,
	initial_rows = 32,
}

colorschemeSetter(config)
keysSetter(config)

return config
