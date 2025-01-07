local wezterm = require("wezterm")
local features = require("features")
local act = wezterm.action
local config = wezterm.config_builder()
local G = require("globals")

-- ENV
config.set_environment_variables = { PATH = "/opt/homebrew/bin:" .. os.getenv("PATH") }
config.default_prog = { "/bin/zsh", "-c", "~/dotfiles/scripts/tmux-attach.zsh" }

-- FONTS
local fontSettings = G.font and { { family = G.font, weight = 400, italic = false } } or {}
local font = wezterm.font_with_fallback(fontSettings)

config.font_rules = { { intensity = "Bold", font = font }, { intensity = "Normal", font = font } }
config.font_size = 16
config.line_height = 1.2
config.window_frame = { font = font }
config.command_palette_font_size = 16

-- COLORS
local scheme = wezterm.color.get_builtin_schemes()[G.colorscheme]

local oled = G.OLED and "#000000" or G.background
scheme.background = oled or scheme.background

local overrides = {
	["rose-pine"] = { background = "#12101A" },
	["rose-pine-moon"] = { background = "#12101A" },
}

for colorscheme, override in pairs(overrides) do
	if G.colorscheme == colorscheme then
		for property, value in pairs(override) do
			scheme[property] = value

			if property == "background" then
				scheme.background = oled or value
			end
		end
	end
end

config.color_scheme = "CustomTheme"
config.color_schemes = { ["CustomTheme"] = scheme }
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }
config.command_palette_bg_color = scheme.background
config.command_palette_fg_color = scheme.foreground

-- WINDOW
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.macos_window_background_blur = 50
config.window_background_opacity = G.opacity
config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.front_end = "WebGpu"
config.bidi_enabled = true
config.max_fps = 120

-- CURSOR
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.hide_mouse_cursor_when_typing = true
config.animation_fps = 120

-- KEYBINDINGS
config.disable_default_key_bindings = true
config.keys = {
	features.cmd_to_tmux_prefix("k", "k"),
	features.cmd_to_tmux_prefix("j", "j"),
	{ key = "z", mods = "CMD|CTRL", action = wezterm.action_callback(features.decreaseOpacity) },
	{ key = "c", mods = "CMD|CTRL", action = wezterm.action_callback(features.increaseOpacity) },
	{ key = "x", mods = "CMD|CTRL", action = wezterm.action_callback(features.resetOpacity) },
	{ key = "k", mods = "CMD|CTRL", action = wezterm.action_callback(features.theme_switcher) },
	{ key = "f", mods = "CMD|CTRL", action = wezterm.action_callback(features.font_switcher) },
	{ key = "b", mods = "CMD|CTRL", action = features.global_bg() },
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

return config
