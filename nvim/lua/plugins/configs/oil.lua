local oil = require("oil")

oil.setup({
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	lsp_file_methods = { autosave_changes = true },
	watch_for_changes = true,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _) return name:match(".DS_Store") end,
	},

	keymaps = {
		-- ["<C-s>"] = function() oil.save({ confirm = false }) end, -- dangerous save
		["<C-s>"] = false,
		["<C-v>"] = { "actions.select", opts = { vertical = true } },
		["<left>"] = { "actions.parent", mode = "n" },
		["<right>"] = { "actions.select", mode = "n" },
		["<ESC>"] = { "actions.close", mode = "n" },
		["<leader>e"] = { "actions.close", mode = "n" },
	},
})

vim.keymap.set("n", "-", function() oil.open_float(vim.fn.getcwd(), { preview = {} }) end, { desc = "Open oil in cwd" })
vim.keymap.set(
	"n",
	"<leader>e",
	function() oil.open_float(nil, { preview = {} }) end,
	{ desc = "Open oil in current directory" }
)
