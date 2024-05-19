local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

M.theme_switcher = function(window, pane)
	-- get builtin color schemes
	local schemes = wezterm.get_builtin_color_schemes()
	local choices = {}
	local config_path = "~/dotfiles/wezterm/wezterm.lua"

	-- populate theme names in choices list
	for key, _ in pairs(schemes) do
		table.insert(choices, { label = tostring(key) })
	end

	-- sort choices list
	table.sort(choices, function(c1, c2)
		return c1.label < c2.label
	end)

	window:perform_action(
		act.InputSelector({
			title = "🎨 Pick a Theme!",
			choices = choices,
			fuzzy = true,

			-- execute 'sed' shell command to replace the line responsible of colorscheme in my config
			action = wezterm.action_callback(function(inner_window, inner_pane, _, label)
				inner_window:perform_action(
					act.SpawnCommandInNewTab({
						args = {
							"gsed",
							"-i",
							'/^M.colorscheme/c\\M.colorscheme = "' .. label .. '"',
							config_path,
						},
					}),
					inner_pane
				)
			end),
		}),
		pane
	)
end

-- https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration
M.conditionalActivatePane = function(window, pane, pane_direction, vim_direction)
	local isViProcess = pane:get_foreground_process_name():find("n?vim") ~= nil

	if isViProcess then
		window:perform_action(act.SendKey({ key = vim_direction, mods = "ALT" }), pane)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

return M
