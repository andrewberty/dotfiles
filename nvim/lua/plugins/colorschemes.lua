return {
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
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nord").setup({
				transparent = true,
				styles = {},

				---@param colors Nord.Palette
				on_colors = function(colors) end,

				on_highlights = function(hls, c)
					hls.StatusLine.bg = c.none
					hls.StatusLineNC.bg = c.none
					hls.WinBar.bg = c.none
					hls.WinBarNC.bg = c.none
					hls.NormalFloat.bg = c.none
					hls.FloatBorder.bg = c.none
				end,
			})
		end,
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
				WinBar = { bg = "none" },
				WinBarNC = { bg = "none" },
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },
			},
		},
	},
}
