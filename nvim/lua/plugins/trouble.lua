return {
	"folke/trouble.nvim",
	---@class trouble.Config
	opts = {
		focus = true,
		throttle = { follow = 50, preview = { ms = 50, debounce = true } },
		---@type trouble.Window.opts
		win = {
			size = { width = 70 },
			position = "right",
		},
		preview = { type = "main", scratch = false },
	},
	specs = {
		"folke/snacks.nvim",
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts or {}, {
				picker = {
					actions = require("trouble.sources.snacks").actions,
					win = { input = { keys = { ["<c-q>"] = { "trouble_open", mode = { "n", "i" } } } } },
				},
			})
		end,
	},
	cmd = "Trouble",
	keys = {
		{
			"gD",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
	},
}
