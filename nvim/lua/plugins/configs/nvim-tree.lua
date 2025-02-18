vim.keymap.set({ "n", "v" }, "<leader>e", ":NvimTreeToggle<CR>", { desc = "Nvim Tree Toggle", silent = true })
require("mini.icons").mock_nvim_web_devicons()

local custom_on_attach = function(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#555555" })

	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
end

require("nvim-tree").setup({
	on_attach = custom_on_attach,
	filters = {
		git_ignored = false,
		custom = { ".DS_Store" },
	},
	view = {
		centralize_selection = false,
		cursorline = true,
		debounce_delay = 15,
		width = {
			min = 20,
			max = -1,
		},
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = { cmd = "trash" },
	renderer = {
		root_folder_label = ":t",
		indent_width = 2,
		highlight_git = false,
		indent_markers = {
			enable = true,
		},
	},
	actions = {
		change_dir = {
			enable = true,
			global = true,
		},
		open_file = {
			quit_on_open = false,
			window_picker = {
				enable = false,
			},
		},
	},
	ui = {
		confirm = {
			default_yes = true,
		},
	},
})
