local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

M.globals_dir = wezterm.config_dir .. "/globals.json"

M.getLuaFromJSON = function()
	local file = assert(io.open(M.globals_dir, "r"))
	local json = file:read("a")
	file:close()
	return wezterm.serde.json_decode(json)
end

M.writeLuaToJSON = function(lua)
	local json = wezterm.serde.json_encode_pretty(lua)
	local file = assert(io.open(M.globals_dir, "w"))
	file:write(json)
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
	local fonts = M.getLuaFromJSON().fonts
	local action = wezterm.action_callback(function(_, _, _, label)
		if label then
			local lua = M.getLuaFromJSON()
			lua.font = fonts[label]
			M.writeLuaToJSON(lua)
		end
	end)

	M.switcher(window, pane, "🎨 Pick a Font!", fonts, action)
end

M.theme_switcher = function(window, pane)
	local schemes = wezterm.get_builtin_color_schemes()
	local action = wezterm.action_callback(function(_, _, _, label)
		if label then
			local lua = M.getLuaFromJSON()
			lua.colorscheme = label
			M.writeLuaToJSON(lua)
		end
	end)

	M.switcher(window, pane, "🎨 Pick a Theme!", schemes, action)
end

M.togglePadding = function()
	local lua = M.getLuaFromJSON()
	if lua.padding.top == 0 then
		lua.padding = { top = 20, bottom = 20, left = 20, right = 20 }
	else
		lua.padding = { top = 0, bottom = 0, left = 0, right = 0 }
	end
	M.writeLuaToJSON(lua)
end

M.increaseOpacity = function()
	local lua = M.getLuaFromJSON()
	if lua.opacity <= 1 then
		lua.opacity = lua.opacity + 0.01
		M.writeLuaToJSON(lua)
	end
end
M.decreaseOpacity = function()
	local lua = M.getLuaFromJSON()
	if lua.opacity >= 0.5 then
		lua.opacity = lua.opacity - 0.01
		M.writeLuaToJSON(lua)
	end
end
M.resetOpacity = function()
	local lua = M.getLuaFromJSON()
	lua.opacity = 1
	M.writeLuaToJSON(lua)
end

-- CENTER AUTOMATICALLY
-- wezterm.on("gui-startup", function()
-- 	local screen = wezterm.gui.screens().main
-- 	local ratio = 0.7
-- 	local width, height = 1800, 1169
-- 	-- local width, height = screen.width * ratio, screen.height * ratio
-- 	local tab, pane, window = wezterm.mux.spawn_window({
-- 		position = { x = (screen.width - width) / 2, y = (screen.height - height) / 2 },
-- 	})
-- 	print(screen.width, screen.height)
-- 	-- window:gui_window():maximize()
-- 	window:gui_window():set_inner_size(width, height)
-- end)

-- NAVIGATOR
M.conditionalActivatePane = function(window, pane, pane_direction, vim_direction)
	if pane:get_foreground_process_name():find("n?vim") ~= nil then
		window:perform_action(act.SendKey({ key = vim_direction, mods = "ALT" }), pane)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	M.conditionalActivatePane(window, pane, "Right", "RightArrow")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	M.conditionalActivatePane(window, pane, "Left", "LeftArrow")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	M.conditionalActivatePane(window, pane, "Up", "UpArrow")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	M.conditionalActivatePane(window, pane, "Down", "DownArrow")
end)

return M
