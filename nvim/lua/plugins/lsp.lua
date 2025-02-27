return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local luasnip = require("luasnip")
			local blink = require("blink.cmp")

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }

					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
				end,
			})

			vim.diagnostic.config({
				float = { border = "rounded" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.filetype_extend("javascript", { "html", "javascriptreact" })
			luasnip.filetype_extend("javascriptreact", { "html" })
			luasnip.filetype_extend("typescriptreact", { "html" })

			---@diagnostic disable-next-line: missing-fields
			require("mason-lspconfig").setup({
				automatic_installation = true,
				handlers = {
					function(server_name) lspconfig[server_name].setup({ capabilities = blink.get_lsp_capabilities() }) end,

					["tailwindcss"] = function()
						lspconfig["tailwindcss"].setup({
							settings = { tailwindCSS = { experimental = { classRegex = { { "([a-zA-Z0-9\\-:]+)" } } } } },
						})
					end,
				},
			})
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		opts = {
			settings = {
				tsserver_file_preferences = { importModuleSpecifierPreference = "non-relative" },
				expose_as_code_action = "all",
			},
		},
	},
}
