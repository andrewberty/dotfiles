local telescope = require("telescope")

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "dist", ".git", ".next", ".DS_Store" },
		path_display = { "filename_first" },
		sorting_strategy = "ascending",
		layout_strategy = "flex",
		layout_config = {
			horizontal = {
				width = 0.99,
				height = 0.99,
				preview_width = 0.5,
			},
			vertical = {
				width = 0.99,
				height = 0.99,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
		},
	},
	extensions = {
		themes = {
			layout_strategy = "vertical",
			layout_config = {
				vertical = {
					height = 0.4,
					width = 0.4,
					prompt_position = "top",
				},
				horizontal = {
					width = 0.8,
					height = 0.7,
				},
			},
			light_themes = {
				ignore = true,
				keywords = { "light", "day", "frappe", "latte", "dawn" },
			},
			enable_previewer = false,
			enable_live_preview = true,
			persist = {
				enabled = true,
				path = vim.fn.stdpath("config") .. "/lua/theme.lua",
			},
		},
	},
	mappings = {
		i = {
			["<C-h>"] = require("telescope.actions").file_split,
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>sh", ":Telescope help_tags<cr>", { desc = "Find Help", silent = true })
vim.keymap.set(
	{ "n", "v" },
	"<leader>sH",
	":Telescope highlights<cr>",
	{ desc = "Find highlight groups", silent = true }
)
vim.keymap.set({ "n", "v" }, "<leader>st", ":Telescope live_grep<cr>", { desc = "Live Grep", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sk", ":Telescope keymaps<cr>", { desc = "Keymaps", silent = true })
vim.keymap.set({ "n", "v" }, "<c-k>", ":Telescope commands<cr>", { desc = "Commands", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sr", ":Telescope resume<cr>", { desc = "Resume last search", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sz", ":Telescope zoxide list<cr>", { desc = "Zoxide", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>f", ":Telescope find_files<cr>", { desc = "Find Files", silent = true })
vim.keymap.set(
	{ "n", "v" },
	"<leader>sf",
	":Telescope current_buffer_fuzzy_find<cr>",
	{ desc = "Search in Buffer", silent = true }
)
vim.keymap.set({ "n", "v" }, "<leader>th", ":Telescope themes<cr>", { desc = "Theme switcher", silent = true })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })

telescope.load_extension("ui-select")
telescope.load_extension("zoxide")
telescope.load_extension("themes")
telescope.load_extension("noice")
