local wezterm = require("wezterm")

local M = {}

M.globalsPath = os.getenv("HOME") .. "/dotfiles/wezterm/globals.toml"

M.DEFAULTS = {
	OLED = false,
	brightness = 0,
	cell_width = 1.0,
	colorscheme = "rose-pine",
	font = "SF Mono",
	font_size = 14,
	line_height = 1.2,
	opacity = 1.0,
}

local function roundfloats(t)
	local keys = { "brightness", "cell_width", "font_size", "line_height", "opacity" }
	for _, k in ipairs(keys) do
		if t[k] then
			t[k] = math.floor(t[k] * 1000 + 0.5) / 1000
		end
	end
	return t
end

M.readGlobals = function()
	local file = assert(io.open(M.globalsPath, "r"))
	local globals = file:read("*a")
	file:close()
	return wezterm.serde.toml_decode(globals)
end

M.get = function(key)
	local g = M.readGlobals()
	return g[key] or M.DEFAULTS[key]
end

M.setGlobals = function(callback)
	local globals = M.readGlobals()
	callback(globals)
	roundfloats(globals)
	local file = assert(io.open(M.globalsPath, "w"))
	file:write(wezterm.serde.toml_encode(globals))
	file:close()
end

return M
