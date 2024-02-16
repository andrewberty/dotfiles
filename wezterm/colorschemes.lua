local wezterm = require("wezterm")

function Setter(config)
	local function get_theme()
		local scheme = wezterm.color.get_builtin_schemes()[wezterm.GLOBAL.Colorscheme]
		local scheme_overrides = {
			-- background = "#11111b", -- catppuccin mocha bg
			-- background = "#011628", -- tokyonight blue bg
			-- background = "#101010", -- gruvbox hard bg
			background = "#000",
			split = "#111",
		}

		for key, value in pairs(scheme_overrides) do
			scheme[key] = value
		end

		return scheme
	end

	local darkened_bg = wezterm.color.parse(get_theme().background):darken(0.1)

	wezterm.on("toggle-OLED", function(window)
		local overrides = window:get_config_overrides() or {}
		if not overrides.color_schemes then
			local oled_theme = get_theme()
			oled_theme.background = "#000"
			overrides.color_schemes = {
				["OledTheme"] = oled_theme,
			}
			overrides.color_scheme = "OledTheme"
		else
			overrides.color_schemes = nil
			overrides.color_scheme = nil
		end
		window:set_config_overrides(overrides)
	end)

	local opts = {
		color_scheme = "CustomTheme",
		color_schemes = {
			["CustomTheme"] = get_theme(),
		},
		color_scheme_dirs = { "/home/andrew/.config/wezterm/colors" },
		inactive_pane_hsb = {
			saturation = 1,
			brightness = 1,
		},
		window_frame = {
			font = wezterm.font({ family = wezterm.GLOBAL.Font, weight = "Regular" }),
			font_size = 11.0,
			active_titlebar_bg = get_theme().background,
			inactive_titlebar_bg = get_theme().background,
		},
		command_palette_bg_color = darkened_bg,
		command_palette_fg_color = get_theme().foreground,
		command_palette_font_size = 12,
		colors = {
			tab_bar = {
				background = get_theme().background,
				inactive_tab_edge = get_theme().background,
				active_tab = {
					bg_color = get_theme().background,
					fg_color = "#eee",
					-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
					intensity = "Normal",
					-- Specify whether you want "None", "Single" or "Double" underline for
					underline = "None",
					italic = false,
					strikethrough = false,
				},
				inactive_tab = {
					bg_color = get_theme().background,
					fg_color = "#555",
					intensity = "Normal",
					underline = "None",
					italic = false,
					strikethrough = false,
				},
				inactive_tab_hover = {
					bg_color = get_theme().background,
					fg_color = "#eee",
					intensity = "Normal",
					underline = "None",
					italic = false,
					strikethrough = false,
				},

				new_tab = {
					bg_color = get_theme().background,
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
