local wezterm = require("wezterm")
local globals = require("utils.globals")

local G = globals.readGlobals()
local M = {}

local scheme = wezterm.color.get_builtin_schemes()[G.colorscheme]
	or wezterm.color.load_scheme(os.getenv("HOME") .. "/dotfiles/wezterm/colors/" .. G.colorscheme .. ".toml")

local oled = G.OLED and "#000000" or G.background
scheme.background = oled or scheme.background

local overrides = {
	["rose-pine"] = { background = "#12101A" },
	["rose-pine-moon"] = { background = "#12101A" },
	["tokyonight"] = { background = "#161720" },
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
