local wezterm = require("wezterm")

local function centerWindow()
	local screen = wezterm.gui.screens().active
	local ratio = 0.98
	local notch_height = 100
	local width, height = screen.width * ratio, (screen.height - notch_height) * ratio

	local _, _, window = wezterm.mux.spawn_window({
		position = {
			x = screen.width - width,
			y = screen.height - height + notch_height,
		},
	})
	window:gui_window():set_inner_size(width, height)
end

wezterm.on("update-right-status", function(window, pane)
	local workspace = wezterm.format({
		{ Foreground = { AnsiColor = "Green" } },
		{ Text = wezterm.nerdfonts.cod_layout_panel_right },
	}) .. " " .. window:active_workspace() .. " "

	local status = workspace
	window:set_right_status(status)
end)

wezterm.on("gui-startup", function()
	centerWindow()
end)
