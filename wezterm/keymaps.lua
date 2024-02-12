local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
	{ key = "f", mods = "ALT", action = act.EmitEvent("toggle-tabbar") },
	{ key = "p", mods = "CTRL", action = act.EmitEvent("toggle-padding") },
	{ key = "o", mods = "CTRL|ALT", action = act.EmitEvent("toggle-OLED") },
	{ key = "c", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
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
			local schemes = wezterm.get_builtin_color_schemes()
			local choices = {}

			for key, _ in pairs(schemes) do
				table.insert(choices, { label = tostring(key) })
			end

			window:perform_action(
				act.InputSelector({
					title = "Theme Switcher",
					choices = choices,
					fuzzy = true,

					action = wezterm.action_callback(function(window, _, _, label)
						-- local overrides = window:get_config_overrides() or {}
						-- overrides.color_scheme = label
						-- window:set_config_overrides(overrides)
						wezterm.GLOBAL.Colorscheme = label
					end),
				}),
				pane
			)
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
			cwd = os.getenv("WEZTERM_CONFIG_DIR"),
			set_environment_variables = { TERM = "screen-256color" },
			args = { "nvim", os.getenv("WEZTERM_CONFIG_FILE") },
		}),
	},
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
