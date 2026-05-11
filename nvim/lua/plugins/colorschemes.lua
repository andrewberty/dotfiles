---@diagnostic disable: missing-fields
return {
	{
		"wtfox/jellybeans.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			italics = false,
			bold = false,
			flat_ui = false,
			on_highlights = function(hl, c)
				hl.FloatBorder.bg = c.none
				hl.WinBar.bg = c.none
				hl.WinBarNC.bg = c.none
				hl.StatusLine.bg = c.none
				hl.StatusLineNC.bg = c.none
			end,
			-- on_colors = function(colors) end,
		},
	},
	{
		"vague-theme/vague.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("vague").setup({
				transparent = true,
				bold = false,
				italic = false,
				on_highlights = function(hl, colors)
					hl.FloatBorder = { fg = colors.comment }
					hl.WinBar.bg = nil
				end,
				-- colors = {
				-- 	bg = "#141415",
				-- 	inactiveBg = "#1c1c24",
				-- 	fg = "#cdcdcd",
				-- 	floatBorder = "#878787",
				-- 	line = "#252530",
				-- 	comment = "#606079",
				-- 	builtin = "#b4d4cf",
				-- 	func = "#c48282",
				-- 	string = "#e8b589",
				-- 	number = "#e0a363",
				-- 	property = "#c3c3d5",
				-- 	constant = "#aeaed1",
				-- 	parameter = "#bb9dbd",
				-- 	visual = "#333738",
				-- 	error = "#d8647e",
				-- 	warning = "#f3be7c",
				-- 	hint = "#7e98e8",
				-- 	operator = "#90a0b5",
				-- 	keyword = "#6e94b2",
				-- 	type = "#9bb4bc",
				-- 	search = "#405065",
				-- 	plus = "#7fa563",
				-- 	delta = "#f3be7c",
				-- },
			})
		end,
	},
	{
		"tinted-theming/tinted-nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("tinted-nvim").setup({
				compile = false,
				capabilities = { undercurl = true },
				ui = { transparent = true },
				styles = {
					comments = { italic = false },
					keywords = {},
					functions = {},
					variables = {},
					types = {},
				},
				highlights = {
					overrides = function(palette)
						return {
							StatusLine = { bg = "none" },
						}
					end,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = { sidebars = "transparent", floats = "transparent" },
			on_highlights = function(hl, c)
				hl.StatusLine.bg = c.none
				hl.StatusLineNC.bg = c.none
				hl.SnacksIndent.fg = c.bg_visual
				hl.SnacksIndent.blend = 80
			end,
		},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		opts = {
			bold_vert_split = false,
			styles = {
				bold = false,
				transparency = true,
			},
			highlight_groups = {
				WinSeparator = { fg = "overlay" },
				TelescopeNormal = { bg = "Normal" },
				FloatBorder = { fg = "overlay" },
				TelescopeBorder = { fg = "overlay", bg = "none" },
				TelescopeSelection = { bg = "Normal" },
				TelescopeSelectionCaret = { bg = "Normal" },
				VertSplit = { fg = "overlay" },
				StatusLine = { bg = "none" },
				WinBar = { link = "StatusLine" },
				WinBarNC = { link = "StatusLine" },
				StatusLineNC = { link = "StatusLine" },
				StatusLineTerm = { link = "StatusLine" },
				StatusLineTermNC = { link = "StatusLine" },
			},
		},
	},
}
