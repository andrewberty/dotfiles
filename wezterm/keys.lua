local wezterm = require("wezterm")
local features = require("features")
local act = wezterm.action

local M = {}

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local function handle_wezterm_nvim_splits(key, direction)
	return {
		key = key,
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({
					SendKey = { key = key, mods = "ALT" },
				}, pane)
			else
				win:perform_action({ ActivatePaneDirection = direction }, pane)
			end
		end),
	}
end

M.apply = function(config)
	-- config.disable_default_key_bindings = true

	config.keys = {
		{ key = "b", mods = "CTRL", action = features.global_bg() },
		{ key = "o", mods = "CMD|CTRL", action = wezterm.action_callback(features.toggleOLED) },
		{ key = "k", mods = "CMD", action = features.sesh() },
		{ key = "k", mods = "CTRL", action = features.themes() },
		{ key = "f", mods = "CTRL", action = features.fonts() },
		{ key = "z", mods = "OPT", action = wezterm.action_callback(features.moreOpacity) },
		{ key = "x", mods = "OPT", action = wezterm.action_callback(features.resetOpacity) },
		{ key = "c", mods = "OPT", action = wezterm.action_callback(features.lessOpacity) },

		{ key = "=", mods = "OPT", action = wezterm.action_callback(features.bg_lighten) },
		{ key = "-", mods = "OPT", action = wezterm.action_callback(features.bg_darken) },
		{ key = "0", mods = "OPT", action = wezterm.action_callback(features.bg_reset_brightenss) },

		{ key = "m", mods = "CMD", action = wezterm.action.Hide },
		{ key = "c", mods = "CMD", action = act.CopyTo("ClipboardAndPrimarySelection") },
		{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
		{ key = "=", mods = "CMD", action = wezterm.action_callback(features.fontSizeUp) },
		{ key = "-", mods = "CMD", action = wezterm.action_callback(features.fontSizeDown) },
		{ key = "0", mods = "CMD", action = wezterm.action_callback(features.fontSizeReset) },

		{ key = "]", mods = "CMD", action = wezterm.action_callback(features.lineHeightUp) },
		{ key = "[", mods = "CMD", action = wezterm.action_callback(features.lineHeightDown) },
		{ key = ";", mods = "CMD", action = wezterm.action_callback(features.lineHeightReset) },

		{ key = ".", mods = "CMD", action = wezterm.action_callback(features.cellWidthUp) },
		{ key = ",", mods = "CMD", action = wezterm.action_callback(features.cellWidthDown) },
		{ key = "/", mods = "CMD", action = wezterm.action_callback(features.cellWidthReset) },

		{ key = "L", mods = "CMD", action = act.ShowDebugOverlay },
		{ key = "P", mods = "CMD", action = act.ActivateCommandPalette },
		{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "q", mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },

		{ key = "\\", mods = "CMD", action = act.SplitHorizontal },
		{ key = "\\", mods = "CMD|SHIFT", action = act.SplitVertical },
		{ key = "j", mods = "CMD", action = act.SplitPane({ direction = "Down", size = { Percent = 25 } }) },
		{ key = "Enter", mods = "CMD", action = act.TogglePaneZoomState },

		handle_wezterm_nvim_splits("LeftArrow", "Left"),
		handle_wezterm_nvim_splits("RightArrow", "Right"),
		handle_wezterm_nvim_splits("UpArrow", "Up"),
		handle_wezterm_nvim_splits("DownArrow", "Down"),
	}
end

return M
