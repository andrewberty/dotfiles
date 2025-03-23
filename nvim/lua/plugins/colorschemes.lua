local hl = function(name, opts) return vim.api.nvim_set_hl(0, name, opts) end

return {
	{
		"tinted-theming/tinted-vim",
		enabled = false,
		config = function()
			vim.g.tinted_background_transparent = 1
			vim.g.tinted_colorspace = 256
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "base16-*",
				callback = function()
					hl("NormalFloat", { bg = "" })
					hl("FloatBorder", { fg = "NvimDarkGray3" })
				end,
			})
		end,
	},
	{
		"datsfilipe/vesper.nvim",
		config = function()
			require("vesper").setup({
				transparent = true,
				italics = {},
				overrides = {
					VertSplit = { fg = "#222222" },
					FloatBorder = { link = "VertSplit" },
					FzfLuaBorder = { link = "FloatBorder" },
					NormalFloat = { bg = "none" },
					Cursor = { bg = "#ffcfa8", fg = "black" },
					MatchParen = { fg = "#ffcfa8", bg = "#343434" },
					Normal = { fg = "white" },
					NonText = { fg = "#555555" },
				},
				palette_overrides = {},
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
}
