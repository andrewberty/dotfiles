local hl = function(name, opts) return vim.api.nvim_set_hl(0, name, opts) end

return {
	-- {
	-- 	"datsfilipe/vesper.nvim",
	-- 	config = function()
	-- 		require("vesper").setup({
	-- 			transparent = true,
	-- 			italics = {},
	-- 			overrides = {
	-- 				FloatBorder = { link = "VertSplit" },
	-- 				MatchParen = { fg = "#ffcfa8", bg = "#343434" },
	-- 			},
	-- 			palette_overrides = {
	-- 				border = "#222222",
	-- 				bgFloat = "none",
	-- 			},
	-- 		})
	-- 	end,
	-- },
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
			},
		},
	},
}
