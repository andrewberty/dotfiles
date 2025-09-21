local M = {}

local wezterm = require("wezterm")

local G = require("utils.globals").readGlobals()

M.apply = function(config)
	local fontSettings = G.font and { { family = G.font, weight = 400, italic = false } } or {}
	local font = wezterm.font_with_fallback(fontSettings)

	config.font_rules = { { intensity = "Bold", font = font }, { intensity = "Normal", font = font } }
	config.font_size = G.font_size or 13
	config.line_height = G.line_height or 1.2
	config.command_palette_font_size = G.font_size + 1
	config.window_frame = { font = font }
end

return M
