require("options")
require("keymaps")
require("autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- BASICS
	{ import = "plugins.colorschemes" },
	"nvim-lua/plenary.nvim",

	-- PLUGINS
	"mbbill/undotree",
	"folke/neodev.nvim",
	"mg979/vim-visual-multi",
	{
		"axelvc/template-string.nvim",
		config = function()
			require("template-string").setup({
				jsx_brackets = false,
				remove_template_string = true,
			})
		end,
	},
	{
		"echasnovski/mini.icons",
		version = false,
		config = function() require("mini.icons").setup() end,
	},
	{
		"echasnovski/mini.starter",
		event = "VimEnter",
		version = "*",
		config = function() require("plugins.configs.mini-starter") end,
	},
	{
		"echasnovski/mini.bufremove",
		version = false,
		config = function() require("mini.bufremove").setup() end,
		keys = { { "<leader>x", "<cmd>lua require('mini.bufremove').delete()<cr>", { desc = "Close Buffer" } } },
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			vim.keymap.set({ "n", "x" }, "s", "<Nop>")
			require("mini.surround").setup({ mappings = { add = "s" } })
		end,
	},
	{ "echasnovski/mini.ai", version = "*", config = function() require("mini.ai").setup() end },
	{ "echasnovski/mini.pairs", event = "VeryLazy", config = function() require("mini.pairs").setup() end },
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = function() require("plugins.configs.lualine") end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ibl").setup({
				scope = { show_start = false, show_end = false },
				indent = { char = "┊" },
				exclude = { filetypes = { "alpha", "dashboard", "NvimTree", "Trouble", "lazy" } },
			})
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		event = "VeryLazy",
		config = function() require("plugins.configs.noice") end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			vim.keymap.set("n", "<leader>r", "<cmd>lua require('gitsigns').reset_hunk()<cr>", { desc = "Reset Hunk" })
			vim.keymap.set(
				"n",
				"<leader>gs",
				"<cmd>lua require('gitsigns').toggle_signs()<cr>",
				{ desc = "Toggle Git Signs" }
			)
			require("gitsigns").setup({ attach_to_untracked = true, current_line_blame = true })
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		keys = {
			{ "<A-Left>", "<cmd>TmuxNavigateLeft<cr>" },
			{ "<A-Down>", "<cmd>TmuxNavigateDown<cr>" },
			{ "<A-Up>", "<cmd>TmuxNavigateUp<cr>" },
			{ "<A-Right>", "<cmd>TmuxNavigateRight<cr>" },
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = { user_default_options = { tailwind = true, RRGGBBAA = true, css = true, css_fn = true } },
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		keys = {
			{
				"<leader>p",
				vim.cmd.MarkdownPreview,
				noremap = true,
				buffer = true,
				desc = "[P]review Markdown",
			},
		},
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"luckasRanarison/tailwind-tools.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"hrsh7th/cmp-nvim-lsp", -- lsp autocompletion
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippets
			"onsails/lspkind.nvim", -- vs-code like pictograms
			"stevearc/conform.nvim",
			"mfussenegger/nvim-lint",
		},
		config = function() require("plugins.configs.lsp") end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{ "windwp/nvim-ts-autotag", config = function() require("nvim-ts-autotag").setup() end },
		},
		config = function() require("plugins.configs.treesitter") end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		version = false,
		dependencies = {
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-ui-select.nvim",
			-- "andrewberty/telescope-themes",
			"sharkdp/fd",
			{ dir = "~/code/telescope-themes" },
		},
		config = function() require("plugins.configs.telescope") end,
	},
	{ "nvim-tree/nvim-tree.lua", config = function() require("plugins.configs.nvim-tree") end },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function() require("plugins.configs.whichkey") end,
	},
	{
		"MagicDuck/grug-far.nvim",
		config = function() require("grug-far").setup({}) end,
		keys = {
			{ "<leader>sg", ":lua require('grug-far').grug_far()<CR>", { desc = "Search and replace", silent = true } },
			{
				"<leader>s.",
				":lua require('grug-far').grug_far({ prefills = { paths = vim.fn.expand('%') } })<CR>",
				{ desc = "Search and replace current file", silent = true },
			},
		},
	},
}, {
	install = { missing = true },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = true, notify = false },
	ui = { border = "rounded" },
	performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})

require("theme")
