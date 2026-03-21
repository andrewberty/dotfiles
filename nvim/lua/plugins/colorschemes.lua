---@diagnostic disable: missing-fields
return {
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
