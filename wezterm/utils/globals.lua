local wezterm = require("wezterm")

local M = {}

M.globalsPath = os.getenv("HOME") .. "/dotfiles/wezterm/globals.toml"

M.readGlobals = function()
	local file = assert(io.open(M.globalsPath, "r"))
	local globals = file:read("*a")
	file:close()
	return wezterm.serde.toml_decode(globals)
end

M.setGlobals = function(callback)
	local globals = M.readGlobals()
	callback(globals)
	local file = assert(io.open(M.globalsPath, "w"))
	file:write(wezterm.serde.toml_encode(globals))
	file:close()
end

return M
