local wezterm = require("wezterm")
local globals = require("utils.globals")

local G = globals.readGlobals()
local M = {}

local scheme_name = G.colorscheme or "rose-pine"

local scheme = wezterm.color.get_builtin_schemes()[scheme_name]
	or wezterm.color.load_scheme(os.getenv("HOME") .. "/dotfiles/wezterm/colors/" .. scheme_name .. ".toml")
	or "rose-pine"

local oled = G.OLED and "#000000"
local derived_bg = G.background or scheme.background
local bg_color_object = wezterm.color.parse(derived_bg)

if G.brightness ~= nil then
	if G.brightness > 0 then
		derived_bg = bg_color_object:lighten(G.brightness)
	elseif G.brightness < 0 then
		derived_bg = bg_color_object:darken(-G.brightness)
	end
end

scheme.background = oled or derived_bg

scheme.tab_bar = {
	background = scheme.background,
	active_tab = { bg_color = scheme.background, fg_color = scheme.foreground },
	inactive_tab = {
		bg_color = scheme.background,
		fg_color = wezterm.color.parse(scheme.foreground):darken(0.6):desaturate(1),
	},
	inactive_tab_hover = {
		bg_color = scheme.background,
		fg_color = wezterm.color.parse(scheme.foreground):darken(0.6):desaturate(1),
	},
}

M.apply = function(config)
	config.color_scheme = "CustomTheme"
	config.color_schemes = { ["CustomTheme"] = scheme }
	config.inactive_pane_hsb = { saturation = 1, brightness = 1 }
	config.command_palette_bg_color = scheme.background
	config.command_palette_fg_color = scheme.foreground
end

return M
