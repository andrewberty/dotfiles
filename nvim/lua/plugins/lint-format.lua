return {
	{
		"mfussenegger/nvim-lint",
		enabled = false,
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function() lint.try_lint() end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters = {
					kulala = {
						command = "kulala-fmt",
						args = { "$FILENAME" },
						stdin = false,
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					vue = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					graphql = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					json = { "prettier" },
					jsonc = { "prettier" },
					markdown = { "prettier" },
					toml = { "taplo" },
					sh = { "shfmt" },
					zsh = { "shfmt" },
					http = { "kulala" },
					go = { "gofmt" },
					yaml = { "prettier" },
					yml = { "prettier" },
				},
				format_on_save = function(bufnr)
					if vim.g.disable_autoformat then return end

					local ignore_filetypes = { "markdown" }
					if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then return end
					return { timeout_ms = 500, lsp_fallback = true }
				end,
			})

			vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })

			vim.api.nvim_create_user_command(
				"FormatDisable",
				function() vim.g.disable_autoformat = true end,
				{ desc = "Disable autoformat-on-save", bang = true }
			)

			vim.api.nvim_create_user_command(
				"FormatEnable",
				function() vim.g.disable_autoformat = false end,
				{ desc = "Re-enable autoformat-on-save" }
			)
		end,
	},
}
