local wezterm = require("wezterm")

-- UI
wezterm.on("toggle-tabbar", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.enable_tab_bar then
		overrides.enable_tab_bar = true
	else
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-padding", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_padding then
		overrides.window_padding = {
			top = 20,
			bottom = 20,
			left = 20,
			right = 20,
		}
	else
		overrides.window_padding = nil
	end
	window:set_config_overrides(overrides)
end)

-- OPACITY EVENTS
wezterm.on("increase-opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1 + 0.05
	elseif overrides.window_background_opacity <= 1 then
		overrides.window_background_opacity = overrides.window_background_opacity + 0.05
	end
	window:set_config_overrides(overrides)
end)
wezterm.on("decrease-opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1 - 0.05
	else
		local current_opacity = overrides.window_background_opacity
		overrides.window_background_opacity = current_opacity - 0.05
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("format-tab-title", function(tab)
	return wezterm.format({
		{ Text = "  " },
		{ Attribute = { Intensity = "Half" } },
		{ Text = string.format("%s", tab.tab_index + 1) },
		{ Text = " " },
		{ Text = tab.active_pane.title },
		-- { Text = string.gsub(tab.active_pane.title, "(.*[/\\])(.*)", "%2") },
	})
end)

-- NAVIGATION
-- wezterm.on("ActivatePaneDirection-right", function(window, pane)
-- 	features.conditionalActivatePane(window, pane, "Right", "l")
-- end)
-- wezterm.on("ActivatePaneDirection-left", function(window, pane)
-- 	features.conditionalActivatePane(window, pane, "Left", "h")
-- end)
-- wezterm.on("ActivatePaneDirection-up", function(window, pane)
-- 	features.conditionalActivatePane(window, pane, "Up", "k")
-- end)
-- wezterm.on("ActivatePaneDirection-down", function(window, pane)
-- 	features.conditionalActivatePane(window, pane, "Down", "j")
-- end)
