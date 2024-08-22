local which_key = require("which-key")
which_key.setup({
	plugins = {
		registers = false,
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false, -- default bindings on <c-w>
			nav = false, -- misc bindings to work with windows
			z = false, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	},
	icons = {
		group = "", -- symbol prepended to a group
	},
	win = {
		border = "rounded", -- none, single, double, shadow, rounded
		padding = { 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
})
which_key.add({
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>n", group = "[N]o Highlight" },
	{ "<leader>G", group = "[G]it" },
	{ "<leader>t", group = "[T]odo" },
	{ "<leader>r", group = "[R]ename" },
	{ "<leader>s", group = "[S]earch" },
})
