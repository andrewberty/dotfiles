return {
	{
		"tinted-theming/tinted-nvim",
		config = function()
			require("tinted-colorscheme").with_config({
				supports = { tinty = false, tinted_shell = false, live_reload = false },
			})

			local clear_bg = function(list)
				for _, hl in ipairs(list) do
					vim.cmd("hi " .. hl .. " guibg=NONE")
				end
			end

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "base16-*",
				callback = function()
					clear_bg({
						"Normal",
						"NormalNC",
						"NormalFloat",
						"FloatBorder",
						"SignColumn",
						"StatusLine",
						"LineNr",
						"VertSplit",
						"StatusLineNC",
						"WinBar",
						"WinBarNC",
					})

					local colors = require("tinted-colorscheme").colors
					local hl = require("utils").hl

					if colors then
						hl("FloatBorder", { fg = colors.base03 })
						hl("SnacksIndent", { fg = colors.base01 })
					end
				end,
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
