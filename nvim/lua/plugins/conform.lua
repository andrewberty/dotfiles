return {
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
				blade = { "blade-formatter" },
				http = { "kulala" },
				go = { "gofmt" },
				yaml = { "prettier" },
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
}
