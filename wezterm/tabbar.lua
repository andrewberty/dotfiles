local wezterm = require("wezterm")
local M = {}

M.setup = function(config)
	config.enable_tab_bar = Global.enable_tab_bar

	local opts = {}

	if Global.enable_tab_bar then
		opts = {
			tab_bar_at_bottom = true,
			use_fancy_tab_bar = false,
			show_new_tab_button_in_tab_bar = false,
			tab_max_width = 9999,
		}
	end

	for key, value in pairs(opts) do
		config[key] = value
	end
end

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

return M
