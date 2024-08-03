local theme = require("lualine.themes.auto")

local position = "bottom"
local sections = {
	lualine_a = { "branch" },
	lualine_b = {
		{ "buffers", symbols = { alternate_file = "" } },
		{ "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
	},
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = { { "filename", path = 1, file_status = false, shorting_target = 60 } },
}

local custom_theme = function()
	local t = {}
	for key, _ in pairs(theme) do
		if key == "inactive" then
			t[key] = { a = "NonText", b = "NonText", c = "NonText" }
		else
			t[key] = { a = "Title", b = "Normal", c = "Normal", z = "Title" }
		end
	end
	return t
end

local ignored = { "help", "NvimTree", "lazy", "starter" }

local options = {
	options = {
		theme = custom_theme(),
		icons_enabled = true,
		section_separators = "",
		component_separators = "",
		disabled_filetypes = { statusline = ignored, winbar = ignored },
	},
}

if position == "top" then
	require("lualine").setup(
		vim.tbl_deep_extend(
			"force",
			options,
			{ winbar = sections, inactive_winbar = sections, sections = {}, inactive_sections = {} }
		)
	)
elseif position == "bottom" then
	require("lualine").setup(
		vim.tbl_deep_extend(
			"force",
			options,
			{ winbar = {}, inactive_winbar = {}, sections = sections, inactive_sections = sections }
		)
	)
end
