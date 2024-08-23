local wezterm = require("wezterm")
local features = require("features")
local act = wezterm.action
local config = wezterm.config_builder()
local G = features.getLuaFromTOML()

-- FONTS
local font
if G.font.family == "Default" then
	font = wezterm.font_with_fallback({})
else
	font = wezterm.font_with_fallback({
		{ family = G.font.family, weight = G.font.weight or 400, italic = false },
	})
end

-- G.background = "#12101A"
-- G.background = "#080B13"

if G.OLED then
	G.background = "#000000"
end

config.font_rules = { { intensity = "Bold", font = font }, { intensity = "Normal", font = font } }
config.font_size = G.font.font_size or 16

-- COLORS
local scheme = wezterm.color.get_builtin_schemes()[G.colorscheme]
scheme.background = G.background or scheme.background

if G.colorscheme == "rose-pine" or G.colorscheme == "rose-pine-moon" then
	scheme.background = G.background or "#12101A"
end

if G.colorscheme == "catppuccin-mocha" then
	scheme.background = G.background or "#12101A"
end

if G.colorscheme == "tokyonight" or G.colorscheme == "tokyonight_moon" then
	scheme.background = G.background or "#15161F"
end

config.color_scheme = "CustomTheme"
config.color_schemes = { ["CustomTheme"] = scheme }
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }
config.command_palette_bg_color = scheme.background
config.command_palette_fg_color = scheme.foreground

-- WINDOW
config.enable_tab_bar = false
config.window_padding = G.padding
config.window_close_confirmation = "NeverPrompt"
config.macos_window_background_blur = 50
config.window_background_opacity = G.opacity
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.initial_cols = 140
config.initial_rows = 40
config.enable_scroll_bar = false
config.window_frame = { font = wezterm.font({ family = G.font.family, weight = G.font.weight }) }
config.command_palette_font_size = G.font.font_size or 16
config.front_end = "WebGpu"
config.bidi_enabled = true

-- CURSOR
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.hide_mouse_cursor_when_typing = true
config.animation_fps = 60

-- ENV
config.set_environment_variables = { PATH = "/opt/homebrew/bin:" .. os.getenv("PATH") }

config.disable_default_key_bindings = true
config.keys = {
	features.cmd_to_tmux_prefix("k", "K"),
	{ key = "p", mods = "CMD|CTRL", action = wezterm.action_callback(features.togglePadding) },
	{ key = "z", mods = "CMD|CTRL", action = wezterm.action_callback(features.decreaseOpacity) },
	{ key = "c", mods = "CMD|CTRL", action = wezterm.action_callback(features.increaseOpacity) },
	{ key = "x", mods = "CMD|CTRL", action = wezterm.action_callback(features.resetOpacity) },
	{ key = "k", mods = "CMD|CTRL", action = wezterm.action_callback(features.theme_switcher) },
	{ key = "f", mods = "CMD|CTRL", action = wezterm.action_callback(features.font_switcher) },
	{ key = "o", mods = "CMD|CTRL", action = wezterm.action_callback(features.toggleOLED) },

	{ key = "m", mods = "CMD", action = wezterm.action.Hide },
	{ key = "c", mods = "CMD", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "=", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = act.ResetFontSize },
	{ key = "L", mods = "CMD", action = act.ShowDebugOverlay },
	{ key = "P", mods = "CMD", action = act.ActivateCommandPalette },
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "q", mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },
}
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "CMD|CTRL",
		action = wezterm.action_callback(features.increaseOpacity),
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "CMD|CTRL",
		action = wezterm.action_callback(features.decreaseOpacity),
	},
}

return config
