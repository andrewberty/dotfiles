local wezterm = require("wezterm")
local act = wezterm.action
local features = require("features")

local M = {}

M.keys = {
	{ key = "f", mods = "ALT", action = act.EmitEvent("toggle-tabbar") },
	{ key = "p", mods = "ALT", action = act.EmitEvent("toggle-padding") },

	{ key = "C", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },

	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },

	{ key = "w", mods = "CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "t", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },

	{ key = "\\", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 1 }) },

	-- { key = "LeftArrow", mods = "SHIFT|ALT", action = act.ActivatePaneDirection("Left") },
	-- { key = "RightArrow", mods = "SHIFT|ALT", action = act.ActivatePaneDirection("Right") },
	-- { key = "UpArrow", mods = "SHIFT|ALT", action = act.ActivatePaneDirection("Up") },
	-- { key = "DownArrow", mods = "SHIFT|ALT", action = act.ActivatePaneDirection("Down") },

	{ key = "P", mods = "CTRL", action = wezterm.action.ActivateCommandPalette },

	{ key = "F11", action = act.ToggleFullScreen },
	{
		key = "k",
		mods = "CMD|ALT",
		action = wezterm.action_callback(function(window, pane)
			features.theme_switcher(window, pane)
		end),
	},
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			features.conditionalActivatePane(window, pane, "Left", "LeftArrow")
		end),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			features.conditionalActivatePane(window, pane, "Right", "RightArrow")
		end),
	},
	{
		key = "UpArrow",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			features.conditionalActivatePane(window, pane, "Up", "UpArrow")
		end),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			features.conditionalActivatePane(window, pane, "Down", "DownArrow")
		end),
	},
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = ",",
		mods = "CTRL",
		action = act.SpawnCommandInNewTab({
			cwd = "C:\\Users\\Andrew\\.config\\wezterm",
			args = { "nvim", "wezterm.lua" },
		}),
	},
}

M.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "CTRL|SHIFT",
		action = act.EmitEvent("increase-opacity"),
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "CTRL|SHIFT",
		action = act.EmitEvent("decrease-opacity"),
	},
}

M.setup = function(config)
	config.keys = M.keys
	config.mouse_bindings = M.mouse_bindings
end
return M
