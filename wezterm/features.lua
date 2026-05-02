local wezterm = require("wezterm")
local act = wezterm.action
local picker = require("utils.picker")
local globals = require("utils.globals")
local utils = require("utils.general")

local M = {}

M.global_bg = function()
	return act.PromptInputLine({
		description = wezterm.format({
			{ Attribute = { Underline = "Single" } },
			{ Foreground = { AnsiColor = "Green" } },
			{ Text = "Enter a global bg color! 🎨" },
		}),
		action = wezterm.action_callback(function(_, _, line)
			if line == "" then
				globals.setGlobals(function(G)
					G.background = nil
				end)
			elseif line then
				globals.setGlobals(function(G)
					G.background = line
				end)
			end
		end),
	})
end

M.toggleOLED = function()
	globals.setGlobals(function(G)
		G.OLED = not G.OLED
	end)
end

M.moreOpacity = function()
	globals.setGlobals(function(G)
		if G.opacity > 0.6 then
			G.opacity = G.opacity - 0.01
		end
	end)
end

M.lessOpacity = function()
	globals.setGlobals(function(G)
		if G.opacity < 0.99 then
			G.opacity = G.opacity + 0.01
		end
	end)
end

M.resetOpacity = function()
	globals.setGlobals(function(G)
		G.opacity = 1
	end)
end

M.bg_darken = function()
	globals.setGlobals(function(G)
		G.brightness = utils.clamp((G.brightness or 0) - 0.02, -1.0, 1.0)
	end)
end

M.bg_lighten = function()
	globals.setGlobals(function(G)
		G.brightness = utils.clamp((G.brightness or 0) + 0.02, -1.0, 1.0)
	end)
end

M.bg_reset_brightenss = function()
	globals.setGlobals(function(G)
		G.brightness = 0
	end)
end

M.sesh = function()
	return wezterm.action_callback(function(window, pane)
		local choices = {}
		local dirs_to_scan = {
			"/dotfiles",
			"/dev/*",
			"/code/*",
		}

		-- collect active workspace names once into a set for O(1) lookup
		local active_workspaces = wezterm.mux.get_workspace_names()
		local active_set = {}
		for _, ws in ipairs(active_workspaces) do
			active_set[ws] = true
		end

		for _, dir in ipairs(dirs_to_scan) do
			for _, path in ipairs(wezterm.glob(wezterm.home_dir .. dir)) do
				local relative_path = path:gsub(wezterm.home_dir, "~")
				local basename = utils.getDirNameFromPath(path)

				-- choose icon color based on active status
				local icon_color = active_set[basename] and "Green" or "White"

				local formatted_label = wezterm.format({
					{ Foreground = { AnsiColor = icon_color } },
					{ Text = wezterm.nerdfonts.cod_layout_panel_right },
					{ Text = "  " },
					{ Text = basename },
					{ Text = "  " },
					{ Foreground = { AnsiColor = "Grey" } },
					{ Text = "(" .. relative_path .. ")" },
				})

				table.insert(choices, { id = path, label = formatted_label })
			end
		end

		-- split active/inactive (same logic as before)
		local active_choices, inactive_choices = {}, {}
		for _, c in ipairs(choices) do
			local basename = utils.getDirNameFromPath(c.id)
			if active_set[basename] then
				table.insert(active_choices, c)
			else
				table.insert(inactive_choices, c)
			end
		end

		choices = {}
		for _, c in ipairs(active_choices) do
			table.insert(choices, c)
		end
		for _, c in ipairs(inactive_choices) do
			table.insert(choices, c)
		end

		local action = wezterm.action_callback(function(_, _, id, label)
			if label and id then
				window:perform_action(
					act.SwitchToWorkspace({ name = utils.getDirNameFromPath(id), spawn = { cwd = id } }),
					pane
				)
			end
		end)

		local opts = {
			window = window,
			pane = pane,
			choices = choices,
			title = wezterm.format({
				{ Attribute = { Underline = "Single" } },
				{ Foreground = { AnsiColor = "Green" } },
				{ Text = "Choose a session! 💻  " },
			}),
			action = action,
		}

		picker.pick(opts)
	end)
end

M.themes = function()
	return wezterm.action_callback(function(window, pane)
		local choices = {}

		local schemes = wezterm.get_builtin_color_schemes()
		local custom_schemes_path = wezterm.glob(wezterm.config_dir .. "/colors/*")

		-- loop over builtin schemes
		for scheme, _ in pairs(schemes) do
			table.insert(choices, { label = tostring(scheme) })
		end

		-- loop over custom schemes in {config dir}/colors
		for _, scheme in pairs(custom_schemes_path) do
			local scheme_name = utils.getDirNameFromPath(scheme):gsub(".toml", "")
			table.insert(choices, { label = tostring(scheme_name) })
		end

		-- sort choices list
		table.sort(choices, function(c1, c2)
			return c1.label < c2.label
		end)

		local action = wezterm.action_callback(function(_, _, _, label)
			if label then
				globals.setGlobals(function(G)
					G.colorscheme = label
				end)
			end
		end)

		local opts = {
			window = window,
			pane = pane,
			choices = choices,
			title = wezterm.format({
				{ Attribute = { Underline = "Single" } },
				{ Foreground = { AnsiColor = "Green" } },
				{ Text = "Choose a theme! 🎨" },
			}),
			action = action,
		}

		picker.pick(opts)
	end)
end

M.fonts = function()
	return wezterm.action_callback(function(window, pane)
		local choices = {}

		local _, stdout, _ = wezterm.run_child_process({ "zsh", "-ic", "fc-list :spacing=mono family" })
		-- local _, stdout, _ = wezterm.run_child_process({ "fc-list :spacing=mono family" })

		local list = wezterm.split_by_newlines(stdout)

		-- loop over builtin schemes
		for _, font in pairs(list) do
			if string.sub(font, 1, 1) ~= "." then
				if font:find(",") then
					-- split and take first part
					local first = font:match("([^,]+)")
					table.insert(choices, { label = tostring(first) })
				else
					table.insert(choices, { label = tostring(font) })
				end
			end
		end

		-- sort choices list
		table.sort(choices, function(c1, c2)
			return c1.label < c2.label
		end)

		local action = wezterm.action_callback(function(_, _, _, label)
			if label then
				globals.setGlobals(function(G)
					G.font = label
				end)
			end
		end)

		local opts = {
			window = window,
			pane = pane,
			choices = choices,
			title = wezterm.format({
				{ Attribute = { Underline = "Single" } },
				{ Foreground = { AnsiColor = "Green" } },
				{ Text = "Choose a font! ✏️  " },
			}),
			action = action,
		}

		picker.pick(opts)
	end)
end

M.fontSizeUp = function()
	globals.setGlobals(function(G)
		local current = G.font_size or globals.DEFAULTS.font_size
		G.font_size = current + 0.5
	end)
end

M.fontSizeDown = function()
	globals.setGlobals(function(G)
		local current = G.font_size or globals.DEFAULTS.font_size
		if current > 0.5 then
			G.font_size = current - 0.5
		end
	end)
end

M.fontSizeReset = function()
	globals.setGlobals(function(G)
		G.font_size = globals.DEFAULTS.font_size
	end)
end

M.lineHeightUp = function()
	globals.setGlobals(function(G)
		local current = G.line_height or globals.DEFAULTS.line_height
		G.line_height = current + 0.1
	end)
end

M.lineHeightDown = function()
	globals.setGlobals(function(G)
		local current = G.line_height or globals.DEFAULTS.line_height
		if current > 0.5 then
			G.line_height = current - 0.1
		end
	end)
end

M.lineHeightReset = function()
	globals.setGlobals(function(G)
		G.line_height = globals.DEFAULTS.line_height
	end)
end

M.cellWidthUp = function()
	globals.setGlobals(function(G)
		local current = G.cell_width or globals.DEFAULTS.cell_width
		G.cell_width = current + 0.05
	end)
end

M.cellWidthDown = function()
	globals.setGlobals(function(G)
		local current = G.cell_width or globals.DEFAULTS.cell_width
		if current > 0.5 then
			G.cell_width = current - 0.05
		end
	end)
end

M.cellWidthReset = function()
	globals.setGlobals(function(G)
		G.cell_width = globals.DEFAULTS.cell_width
	end)
end

M.lineHeightUp = function()
	globals.setGlobals(function(G)
		local current = G.line_height or globals.DEFAULTS.line_height
		G.line_height = current + 0.1
	end)
end

M.lineHeightDown = function()
	globals.setGlobals(function(G)
		local current = G.line_height or globals.DEFAULTS.line_height
		if current > 0.5 then
			G.line_height = current - 0.1
		end
	end)
end

M.lineHeightReset = function()
	globals.setGlobals(function(G)
		G.line_height = globals.DEFAULTS.line_height
	end)
end

M.cellWidthUp = function()
	globals.setGlobals(function(G)
		local current = G.cell_width or globals.DEFAULTS.cell_width
		G.cell_width = current + 0.1
	end)
end

M.cellWidthDown = function()
	globals.setGlobals(function(G)
		local current = G.cell_width or globals.DEFAULTS.cell_width
		if current > 0.5 then
			G.cell_width = current - 0.1
		end
	end)
end

M.cellWidthReset = function()
	globals.setGlobals(function(G)
		G.cell_width = globals.DEFAULTS.cell_width
	end)
end

return M
