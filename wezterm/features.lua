local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

M.globals_path = wezterm.config_dir .. "/globals.toml"
M.fonts_path = wezterm.config_dir .. "/fonts.toml"

M.getLuaFromTOML = function(path)
	local file = assert(io.open(path or M.globals_path, "r"))
	local toml = file:read("a")
	file:close()
	return wezterm.serde.toml_decode(toml)
end

M.writeLuaToTOML = function(lua, path)
	local toml = wezterm.serde.toml_encode_pretty(lua)
	local file = assert(io.open(path or M.globals_path, "w"))
	file:write(toml)
	file:close()
end

M.cmd_to_tmux_prefix = function(key, tmux_key)
	return {
		mods = "CMD",
		key = key,
		action = act.Multiple({
			act.SendKey({ mods = "CTRL", key = "a" }),
			act.SendKey({ key = tmux_key }),
		}),
	}
end

M.switcher = function(window, pane, title, data, action)
	local choices = {}

	for key, _ in pairs(data) do
		table.insert(choices, { label = tostring(key) })
	end

	table.sort(choices, function(c1, c2)
		return c1.label < c2.label
	end)

	window:perform_action(act.InputSelector({ title = title, choices = choices, fuzzy = true, action = action }), pane)
end

M.font_switcher = function(window, pane)
	local fonts = M.getLuaFromTOML(M.fonts_path).fonts
	local action = wezterm.action_callback(function(_, _, _, label)
		if label then
			local lua = M.getLuaFromTOML()
			lua.font = fonts[label]
			M.writeLuaToTOML(lua)
		end
	end)

	M.switcher(window, pane, "🎨 Pick a Font!", fonts, action)
end

M.theme_switcher = function(window, pane)
	local schemes = wezterm.get_builtin_color_schemes()
	local action = wezterm.action_callback(function(_, _, _, label)
		if label then
			local lua = M.getLuaFromTOML()
			lua.colorscheme = label
			M.writeLuaToTOML(lua)
		end
	end)

	M.switcher(window, pane, "🎨 Pick a Theme!", schemes, action)
end

M.global_bg = function()
	return act.PromptInputLine({
		description = "Enter a global bg color! 🎨",
		action = wezterm.action_callback(function(_, _, line)
			if line == "" then
				local lua = M.getLuaFromTOML()
				lua.background = nil
				M.writeLuaToTOML(lua)
			elseif line then
				local lua = M.getLuaFromTOML()
				lua.background = line
				M.writeLuaToTOML(lua)
			end
		end),
	})
end

M.togglePadding = function()
	local lua = M.getLuaFromTOML()
	if lua.padding.top == 0 then
		lua.padding = { top = 20, bottom = 20, left = 20, right = 20 }
	else
		lua.padding = { top = 0, bottom = 0, left = 0, right = 0 }
	end
	M.writeLuaToTOML(lua)
end

M.increaseOpacity = function()
	local lua = M.getLuaFromTOML()
	if lua.opacity <= 1 then
		lua.opacity = lua.opacity + 0.01
		M.writeLuaToTOML(lua)
	end
end
M.decreaseOpacity = function()
	local lua = M.getLuaFromTOML()
	if lua.opacity >= 0.5 then
		lua.opacity = lua.opacity - 0.01
		M.writeLuaToTOML(lua)
	end
end
M.resetOpacity = function()
	local lua = M.getLuaFromTOML()
	lua.opacity = 1
	M.writeLuaToTOML(lua)
end

M.toggleOLED = function()
	local lua = M.getLuaFromTOML()
	lua.OLED = not lua.OLED
	M.writeLuaToTOML(lua)
end

return M
