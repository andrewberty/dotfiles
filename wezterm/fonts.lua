local M = {}

local wezterm = require("wezterm")

local globals = require("utils.globals")

M.apply = function(config)
	local fontSettings = globals.get("font") and { { family = globals.get("font"), weight = 400, italic = false } } or {}
	local font = wezterm.font_with_fallback(fontSettings)

	config.font_rules = { { intensity = "Bold", font = font }, { intensity = "Normal", font = font } }
	config.font_size = globals.get("font_size")
	config.line_height = globals.get("line_height")
	config.cell_width = globals.get("cell_width")
	config.command_palette_font_size = globals.get("font_size") + 1
	config.window_frame = { font = font }
end

return M
