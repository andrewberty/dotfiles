return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "antosha417/nvim-lsp-file-operations", config = true },
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			-- disable the annoying deprecated message till fixed
			---@diagnostic disable-next-line: duplicate-set-field
			vim.deprecate = function() end

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"html",
					"cssls",
					"emmet_ls",
					"eslint_d",
					"lua_ls",
					"prettier",
					"shfmt",
					"stylua",
					"tailwindcss",
					"taplo",
					"ts_ls",
					"gopls",
				},
				automatic_enable = {
					exclude = { "ts_ls" },
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }
					local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "must have valid client")

					-- disable lsp semantic highlighting
					client.server_capabilities.semanticTokensProvider = nil

					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
				end,
			})

			vim.diagnostic.config({
				float = { border = "rounded" },
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
			})
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		opts = {
			settings = {
				tsserver_file_preferences = {
					importModuleSpecifierPreference = "non-relative",
					autoImportFileExcludePatterns = { "lucide-react", "react-icons" },
				},
				expose_as_code_action = "all",
			},
		},
	},
}
