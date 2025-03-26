return {
	"nvim-lua/plenary.nvim",

	"mbbill/undotree",

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
	},

	{
		"mg979/vim-visual-multi",
		init = function()
			vim.g.VM_theme = "purplegray"
			-- vim.g.VM_mouse_mappings = 1
			vim.g.VM_maps = {
				["Goto Prev"] = "",
				["Goto Next"] = "",
				["I Return"] = "",
				-- ["I Return"] = "<S-CR>",
				-- ["I BS"] = "",
				-- ["I CtrlB"] = "<M-b>",
				-- ["I CtrlF"] = "<M-f>",
				["I Down Arrow"] = "",
				["I Up Arrow"] = "",
			}
		end,
	},

	{ "axelvc/template-string.nvim", opts = { jsx_brackets = false, remove_template_string = true } },

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			vim.keymap.set("n", "<leader>r", gs.reset_hunk, { desc = "Reset Hunk" })
			vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
			gs.setup({ attach_to_untracked = true, current_line_blame = true })
		end,
	},

	{
		"christoomey/vim-tmux-navigator",
		cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
		keys = {
			{ "<A-Left>", "<cmd>TmuxNavigateLeft<cr>" },
			{ "<A-Down>", "<cmd>TmuxNavigateDown<cr>" },
			{ "<A-Up>", "<cmd>TmuxNavigateUp<cr>" },
			{ "<A-Right>", "<cmd>TmuxNavigateRight<cr>" },
		},
	},

	{
		"NvChad/nvim-colorizer.lua",
		enabled = false,
		opts = { user_default_options = { tailwind = true, css = true, css_fn = true } },
	},

	{ "folke/ts-comments.nvim", opts = {}, event = "VeryLazy" },

	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = { accept_suggestion = "<Tab>", accept_word = "<C-Tab>" },
				color = { suggestion_color = "#666666", cterm = 244 },
			})
		end,
	},
}
