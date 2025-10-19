return {
	{
		"metalelf0/black-metal-theme-neovim",
		lazy = false,
		priority = 1000,
		config = function()
			require("black-metal").setup({
				plain_float = true,
				show_eob = false,
				transparent = true,
				code_style = {},

				diagnostics = { background = false },
				-- colors = {},

				highlights = {
					StatusLine = { bg = "none" },
					StatusLineNC = { bg = "none" },
					StatusLineTerm = { bg = "none" },
					StatusLineTermNC = { bg = "none" },
					WinBar = { bg = "none" },
					WinBarNC = { bg = "none" },

					NvimTreeNormal = { bg = "none" },
					NvimTreeNormalNC = { bg = "none" },
					NvimTreeVertSplit = { bg = "none" },
					NvimTreeEndOfBuffer = { bg = "none" },

					SnacksIndent = { fg = "#333333" },
					CursorLine = { bg = "#333333" }, -- hack to override active item bg
				},
			})
		end,
	},
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
				callback = function()
					local hl = require("utils").set_hl
					hl("WinBar", { link = "StatusLine" })
					hl("WinBarNC", { link = "StatusLineNC" })
					hl("FloatBorder", { link = "NonText" })
				end,
			})
		end,

		-- optionally set the colorscheme within lazy config
		init = function() vim.cmd("colorscheme poimandres") end,
	},
	{
		"tinted-theming/tinted-nvim",
		enabled = false,
		config = function()
			require("tinted-colorscheme").with_config({
				supports = { tinty = false, tinted_shell = false, live_reload = false },
			})

			local hl = require("utils").hl

			local clear_bg = function(list)
				for _, group in ipairs(list) do
					vim.cmd("hi " .. group .. " guibg=NONE")
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

					if colors then
						hl("FloatBorder", { fg = colors.base02 })
						hl("SnacksIndent", { fg = colors.base02 })
						hl("WinSeparator", { fg = colors.base02 })
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
