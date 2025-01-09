local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("gui-startup", function()
	local screen = wezterm.gui.screens().active
	local ratio = 0.85
	local width, height = screen.width * ratio, screen.height * ratio

	local _, _, window = wezterm.mux.spawn_window({
		position = {
			x = screen.width - width,
			y = screen.height - height,
		},
	})
	window:gui_window():set_inner_size(width, height)
end)

local M = {}

M.globalsPath = os.getenv("HOME") .. "/dotfiles/wezterm/globals.toml"
M.scriptsPath = os.getenv("HOME") .. "/dotfiles/wezterm/scripts/"

M.runScript = function(script, args)
	wezterm.background_child_process({ M.scriptsPath .. script, args and args })
end

M.getGlobals = function()
	local file = assert(io.open(M.globalsPath, "r"))
	local globals = file:read("*a")
	file:close()
	return wezterm.serde.toml_decode(globals)
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

M.font_switcher = function()
	M.runScript("font-switcher.zsh")
end

M.theme_switcher = function()
	M.runScript("theme-switcher.zsh")
end

M.global_bg = function()
	return act.PromptInputLine({
		description = "Enter a global bg color! 🎨",
		action = wezterm.action_callback(function(_, _, line)
			if line == "" then
				M.runScript("clear-global-bg.zsh")
			elseif line then
				M.runScript("update-global-bg.zsh", line)
			end
		end),
	})
end

M.increaseOpacity = function()
	M.runScript("inc-opacity.zsh")
end
M.decreaseOpacity = function()
	M.runScript("dec-opacity.zsh")
end
M.resetOpacity = function()
	M.runScript("reset-opacity.zsh")
end

M.toggleOLED = function()
	M.runScript("toggle-oled.zsh")
end

return M
