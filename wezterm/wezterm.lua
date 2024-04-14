require("events")
local wezterm = require("wezterm")
local colorschemeSetter = require("colors")
local keysSetter = require("keymaps")
local global = require("globals")

local config = {
	-- default_prog = { "pwsh.exe", "-nologo" },
	default_domain = "WSL:Ubuntu-22.04",
	font = wezterm.font(global.font.family, { weight = global.font.weight }),
	font_rules = { { intensity = "Bold", font = wezterm.font(global.font.family, { weight = global.font.weight }) } },
	font_size = global.font.font_size,
	line_height = global.font.line_height,
	window_padding = {
		top = 20,
		bottom = 20,
		left = 20,
		right = 20,
	},
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = global.opacity,
	enable_tab_bar = false,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	window_decorations = "RESIZE",
	tab_max_width = 9999,
	adjust_window_size_when_changing_font_size = false,
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	front_end = "OpenGL",
	hide_mouse_cursor_when_typing = true,
	animation_fps = 60,
	enable_scroll_bar = false,
	initial_cols = 90,
	initial_rows = 30,
	disable_default_key_bindings = true,
}

colorschemeSetter(config)
keysSetter(config)

return config
