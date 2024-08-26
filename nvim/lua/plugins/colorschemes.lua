return {
	{
		"olivercederborg/poimandres.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("poimandres").setup({
				disable_background = true,
				disable_float_background = true,
				disable_italics = true,
			})

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "poimandres",
				callback = function() vim.cmd([[hi link WinSeparator NonText]]) end,
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
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			local bg = "#011628"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				transparent = true,
				styles = { functions = {}, variables = {}, sidebars = "transparent", floats = "transparent" },
				on_highlights = function(highlights, colors) highlights.TelescopeSelection = { bg = colors.none } end,

				on_colors = function(colors)
					colors.bg_statusline = colors.none

					colors.bg = bg
					colors.bg_highlight = bg_highlight
					colors.bg_search = bg_search
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
		end,
	},
	{
		"bluz71/vim-nightfly-colors",
		-- enabled = false,
		name = "nightfly",
		priority = 1000,
		config = function()
			for key, value in pairs({
				nightflyCursorColor = true,
				nightflyNormalFloat = true,
				nightlflyTerminalColors = true,
				nightflyTransparent = true,
				nightflyUnderCurls = true,
				nightflyUnderlineMatchParen = true,
				nightflyVirtualTextColor = false,
				nightflyWinSeparator = 0, -- 0 no separators, 1 block separators (default), 2 line separators
			}) do
				vim.g[key] = value
			end

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "nightfly",
				callback = function()
					vim.cmd([[hi VertSplit guibg=none]])
					vim.cmd([[hi TelescopeSelection guibg=none]])
				end,
			})
		end,
	},
	{
		"catppuccin/nvim",
		priority = 1000,
		name = "catppuccin",
		opts = {
			no_bold = true,
			no_underline = true,
			transparent_background = true,
			term_colors = true,
			integrations = {
				grug_far = true,
				nvim_surround = false,
				mason = true,
				noice = true,
				-- telescope = {
				-- 	enabled = true,
				-- 	style = "nvchad",
				-- },
				which_key = true,
			},
		},
	},
}
