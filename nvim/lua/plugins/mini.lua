return {
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
}
