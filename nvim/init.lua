require("core.options")
require("core.keymaps")
require("core.autocmds")

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
	{ import = "colorschemes" },
	"nvim-lua/plenary.nvim",
	-- "nvim-tree/nvim-web-devicons",
	{
		"echasnovski/mini.icons",
		version = false,
		config = function() require("mini.icons").setup() end,
	},

	-- PLUGINS
	{
		"echasnovski/mini.starter",
		event = "VimEnter",
		version = "*",
		config = function() require("configs.mini-starter") end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = function() require("configs.lualine") end,
	},
	{
		"goolord/alpha-nvim",
		enabled = false,
		event = "VimEnter",
		config = function() require("configs.alpha-nvim") end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = { char = "┊" },
				exclude = { filetypes = { "alpha", "dashboard", "NvimTree", "Trouble", "lazy" } },
			})
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		event = "VeryLazy",
		config = function() require("configs.noice") end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = function()
			require("gitsigns").setup({
				attach_to_untracked = true,
				current_line_blame = true,
			})
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
	{ "moll/vim-bbye", keys = { { "<leader>x", "<cmd>Bdelete<cr>", { desc = "Close Buffer" } } } },
	{
		"mg979/vim-visual-multi",
		init = function()
			vim.g.VM_default_mappings = 0
			vim.g.VM_maps = {
				["Select All"] = "\\\\a",
				["Add Cursor At Pos"] = "\\\\\\",
			}
		end,
	},
	"mbbill/undotree",
	"folke/neodev.nvim",
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function() require("nvim-surround").setup() end,
	},
	{ "echasnovski/mini.ai", version = "*", config = function() require("mini.ai").setup() end },
	{
		"echasnovski/mini.move",
		version = "*",
		opts = {
			mappings = {
				down = "<C-down>",
				up = "<C-up>",
				line_down = "<C-down>",
				line_up = "<C-up>",
			},
		},
	},
	{ "echasnovski/mini.pairs", event = "VeryLazy", config = function() require("mini.pairs").setup() end },
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"echasnovski/mini.comment",
		dependencies = { { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true } },
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup({
				hooks = {
					pre = function() require("ts_context_commentstring.internal").update_commentstring({}) end,
				},
			})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" } },
			{ "<leader>S.", '<cmd>lua require("spectre").open_file_search()<CR>', { desc = "Search on current file" } },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
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
			"WhoIsSethDaniel/mason-tool-installer.nvim",
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
		config = function() require("configs.lsp") end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{ "windwp/nvim-ts-autotag", config = function() require("nvim-ts-autotag").setup() end },
		},
		config = function() require("configs.treesitter") end,
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
		config = function() require("configs.telescope") end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		keys = { { "<leader>td", "<cmd>TodoTelescope<cr>", { desc = "Todo Comments" } } },
	},
	{ "nvim-tree/nvim-tree.lua", config = function() require("configs.nvim-tree") end },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function() require("configs.whickey") end,
	},
	-- LAZY OPTYIONS
}, {
	install = { missing = true, colorscheme = { "rose-pine-moon" } },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = true, notify = false },
	ui = { border = "rounded" },
	performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})

require("core.theme")
