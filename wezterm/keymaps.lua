local wezterm = require("wezterm")
local act = wezterm.action

local function theme_switcher(window, pane)
	local schemes = wezterm.get_builtin_color_schemes()
	local choices = {}
	for key, _ in pairs(schemes) do
		table.insert(choices, { label = tostring(key) })
	end
	table.sort(choices, function(c1, c2)
		return c1.label < c2.label
	end)

	window:perform_action(
		act.InputSelector({
			title = "🎨 Pick a Theme!",
			choices = choices,
			fuzzy = true,

			action = wezterm.action_callback(function(inner_window, inner_pane, _, label)
				--TODO: Execute sed Command to replace Colorscheme global variable
				-- sed -i '/Colorscheme/s/".*"/"color"/' wezterm.lua
				inner_window:copy_to_clipboard(label, "ClipboardAndPrimarySelection")
				-- inner_window:perform_action(
				-- 	-- act.SpawnCommandInNewTab({
				-- 	-- 	domain = "DefaultDomain",
				-- 	-- 	cwd = "/mnt/c/Users/Andrew/.config/wezterm/",
				-- 	-- 	args = { 'sed -i \'/Colorscheme/s/".*"/"color"/\'', "test.lua" },
				-- 	-- }),
				-- 	inner_pane
				-- )
			end),
		}),
		pane
	)
end
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
			top = 0,
			bottom = 0,
			left = 0,
			right = 0,
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

local keys = {
	{ key = "f", mods = "ALT", action = act.EmitEvent("toggle-tabbar") },
	{ key = "p", mods = "CTRL", action = act.EmitEvent("toggle-padding") },
	{ key = "C", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "w", mods = "CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "t", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "\\", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "F11", action = act.ToggleFullScreen },
	{
		key = "k",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, pane)
			theme_switcher(window, pane)
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
	-- Doesn't work well in wsl
	-- {
	-- 	key = ",",
	-- 	mods = "CTRL",
	-- 	action = act.SpawnCommandInNewTab({
	-- 		cwd = os.getenv("WEZTERM_CONFIG_DIR"),
	-- 		set_environment_variables = { TERM = "screen-256color" },
	-- 		args = { "nvim", os.getenv("WEZTERM_CONFIG_FILE") },
	-- 	}),
	-- },
}

local mouse_bindings = {
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

function Setter(config)
	config.keys = keys
	config.mouse_bindings = mouse_bindings
end
return Setter
