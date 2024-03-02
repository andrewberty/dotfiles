local wezterm = require("wezterm")

function Setter(config)
	local scheme = wezterm.color.get_builtin_schemes()[Colorscheme]
	scheme.split = "#111111"

	if Background then
		scheme.background = Background
	end

	local bg = wezterm.color.parse(scheme.background)
	local h, s, l = bg:hsla()
	local hsla_bg = "hsla(" .. h .. "," .. s .. "," .. l .. ",0)"
	local darkened_hsla_bg = "hsla(" .. h .. "," .. s .. "," .. l - 0.05 .. ",0.9)"

	local opts = {
		color_scheme = "CustomTheme",
		color_schemes = {
			["CustomTheme"] = scheme,
		},
		inactive_pane_hsb = {
			saturation = 1,
			brightness = 1,
		},
		window_frame = {
			font = wezterm.font({ family = Font, weight = "Regular" }),
			font_size = 11.0,
			active_titlebar_bg = hsla_bg,
			inactive_titlebar_bg = hsla_bg,
		},
		command_palette_bg_color = darkened_hsla_bg,
		command_palette_fg_color = scheme.foreground,
		command_palette_font_size = 13,
		colors = {
			tab_bar = {
				background = hsla_bg,
				inactive_tab_edge = hsla_bg,
				active_tab = {
					bg_color = hsla_bg,
					fg_color = "#eee",
					-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
					intensity = "Normal",
					-- Specify whether you want "None", "Single" or "Double" underline for
					underline = "None",
					italic = false,
					strikethrough = false,
				},
				inactive_tab = {
					bg_color = hsla_bg,
					fg_color = "#555",
					intensity = "Normal",
					underline = "None",
					italic = false,
					strikethrough = false,
				},
				inactive_tab_hover = {
					bg_color = hsla_bg,
					fg_color = "#eee",
					intensity = "Normal",
					underline = "None",
					italic = false,
					strikethrough = false,
				},

				new_tab = {
					bg_color = hsla_bg,
					fg_color = "#808080",
				},
			},
		},
	}

	for key, value in pairs(opts) do
		config[key] = value
	end
end

return Setter
