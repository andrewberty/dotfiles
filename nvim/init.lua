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

local function getConfig(module_name)
	return function() require("plugins.configs." .. module_name) end
end

require("lazy").setup({
	-- BASICS
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
	},
	{ import = "plugins" },
	"nvim-lua/plenary.nvim",

	-- PLUGINS
	"mbbill/undotree",
	"mg979/vim-visual-multi",
	{ "axelvc/template-string.nvim", opts = { jsx_brackets = false, remove_template_string = true } },
	{
		"echasnovski/mini.icons",
		version = false,
		config = function()
			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			vim.keymap.set({ "n", "x" }, "s", "<Nop>")
			require("mini.surround").setup({ mappings = { add = "s" } })

			vim.keymap.set(
				{ "n", "x" },
				"<leader>cn",
				"saq{saq(F(icnjkf)i,classNamejkF(",
				{ remap = true, silent = true, desc = "Surround around quotes with cn()" }
			)
		end,
	},
	{ "echasnovski/mini.ai", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },
	{ "nvim-lualine/lualine.nvim", event = { "BufReadPost", "BufNewFile", "VeryLazy" }, config = getConfig("lualine") },
	{ "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" }, event = "VeryLazy", config = getConfig("noice") },
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
	{ "neovim/nvim-lspconfig", dependencies = { "saghen/blink.cmp" } },
	{ "williamboman/mason.nvim", opts = {} },
	"williamboman/mason-lspconfig.nvim",
	"stevearc/conform.nvim",
	"mfussenegger/nvim-lint",
	"pmizio/typescript-tools.nvim",
	{ "antosha417/nvim-lsp-file-operations", config = true },
	{
		"saghen/blink.cmp",
		event = { "InsertEnter" },
		dependencies = { "rafamadriz/friendly-snippets", { "L3MON4D3/LuaSnip", version = "v2.*" } },
		version = "*",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			{ "windwp/nvim-ts-autotag", opts = {} },
			{
				"bezhermoso/tree-sitter-ghostty",
				build = "make nvim_install",
			},
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
	{ "nvim-tree/nvim-tree.lua", config = getConfig("nvim-tree"), enabled = true },
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
	{ "ibhagwan/fzf-lua", config = getConfig("fzf-lua"), enabled = false },
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = { accept_suggestion = "<Tab>", accept_word = "<C-Tab>" },
				color = { suggestion_color = "#666666", cterm = 244 },
			})
		end,
	},
	{ "mikavilpas/yazi.nvim", event = "VeryLazy", config = getConfig("yazi") },
	{ "mistweaverco/kulala.nvim", config = getConfig("kulala") },
}, {
	rocks = { enabled = false, hererocks = false },
	install = { missing = true },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = true, notify = false },
	ui = { border = "rounded" },
	performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})

require("theme")
require("plugins.configs.lsp")
