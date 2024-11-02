require("options")
require("keymaps")
require("autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- @diagnostic disable-next-line: undefined-field
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

local function getConfig(module_name)
	return function() require("plugins.configs." .. module_name) end
end

require("lazy").setup({
	-- BASICS
	{ import = "plugins.colorschemes" },
	"nvim-lua/plenary.nvim",

	-- PLUGINS
	"mbbill/undotree",
	"folke/neodev.nvim",
	"mg979/vim-visual-multi",
	{ "Exafunction/codeium.nvim", opts = {} },
	{ "axelvc/template-string.nvim", opts = { jsx_brackets = false, remove_template_string = true } },
	{ "echasnovski/mini.icons", version = false, opts = {} },
	{ "echasnovski/mini.starter", event = "VimEnter", version = "*", config = getConfig("mini-starter") },
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			vim.keymap.set({ "n", "x" }, "s", "<Nop>")
			require("mini.surround").setup({ mappings = { add = "s" } })
		end,
	},
	{ "echasnovski/mini.ai", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },
	{ "nvim-lualine/lualine.nvim", event = { "BufReadPost", "BufNewFile", "VeryLazy" }, config = getConfig("lualine") },
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
	{ "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" }, event = "VeryLazy", config = getConfig("noice") },
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
		opts = { user_default_options = { tailwind = true, css = true, css_fn = true } },
	},
	{ "folke/ts-comments.nvim", opts = {}, event = "VeryLazy" },
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
	{ "MeanderingProgrammer/render-markdown.nvim", opts = {} },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		event = { "BufReadPre", "BufNewFile" },
		init = function() vim.g.lsp_zero_ui_float_border = 0 end,
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"luckasRanarison/tailwind-tools.nvim",
			"pmizio/typescript-tools.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			"hrsh7th/nvim-cmp",
			{ "jackieaskins/cmp-emmet", build = "npm run release" },
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
		config = getConfig("lsp"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{ "windwp/nvim-ts-autotag", opts = {} },
		},
		config = getConfig("treesitter"),
	},
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
		lazy = false,
		version = false,
		dependencies = {
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-ui-select.nvim",
			-- "andrewberty/telescope-themes",
			"sharkdp/fd",
			{ dir = "~/code/telescope-themes" },
		},
		config = getConfig("telescope"),
	},
	{ "nvim-tree/nvim-tree.lua", config = getConfig("nvim-tree") },
	{ "folke/which-key.nvim", event = "VeryLazy", config = getConfig("whichkey") },
	{
		"MagicDuck/grug-far.nvim",
		config = function()
			require("grug-far").setup({})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("my-grug-far-custom-keybinds", { clear = true }),
				pattern = { "grug-far" },
				callback = function()
					vim.keymap.set("n", "<localleader>w", function()
						local state = unpack(require("grug-far").toggle_flags({ "--fixed-strings" }))
						vim.notify("grug-far: toggled --fixed-strings " .. (state and "ON" or "OFF"))
					end, { buffer = true })
				end,
			})
		end,
		keys = {
			{
				"<leader>sg",
				":lua require('grug-far').grug_far({ transient = true })<CR>",
				{ desc = "Search and replace", silent = true },
			},
			{
				"<leader>s.",
				":lua require('grug-far').grug_far({transient = true, prefills = { paths = vim.fn.expand('%') } })<CR>",
				{ desc = "Search and replace current file", silent = true },
			},
		},
	},
	{ "kdheepak/lazygit.nvim", keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } } },
	{
		"OlegGulevskyy/better-ts-errors.nvim",
		config = {
			keymaps = {
				toggle = "<leader>dd", -- default '<leader>dd'
				go_to_definition = "<leader>dx", -- default '<leader>dx'
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		config = getConfig("fzf-lua"),
	},
}, {
	rocks = { enabled = false, hererocks = false },
	install = { missing = true },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = true, notify = false },
	ui = { border = "rounded" },
	performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})

require("theme")
