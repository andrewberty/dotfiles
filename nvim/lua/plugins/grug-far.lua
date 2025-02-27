return {
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
}
