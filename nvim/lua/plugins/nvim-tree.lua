return {
	"nvim-tree/nvim-tree.lua",
	enabled = true,
	config = function()
		vim.keymap.set({ "n", "v" }, "<leader>e", ":NvimTreeToggle<CR>", { desc = "Nvim Tree Toggle", silent = true })
		vim.keymap.set({ "n", "v" }, "<leader>E", ":NvimTreeFindFile<CR>", { desc = "Nvim Tree Find File", silent = true })
		require("mini.icons").mock_nvim_web_devicons()

		local custom_on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#333333" })

			api.config.mappings.default_on_attach(bufnr)
			vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
		end

		require("nvim-tree").setup({
			on_attach = custom_on_attach,
			filters = { git_ignored = false, custom = { ".DS_Store" } },
			view = { width = { min = 20, max = -1 }, side = "left" },
			trash = { cmd = "trash" },
			renderer = {
				root_folder_label = ":t",
				highlight_git = false,
				indent_markers = { enable = true },
			},
			-- update_focused_file = { enable = true },
			actions = {
				change_dir = { global = true },
				open_file = { window_picker = { enable = false } },
			},
			ui = { confirm = { default_yes = true } },
		})
	end,
}
