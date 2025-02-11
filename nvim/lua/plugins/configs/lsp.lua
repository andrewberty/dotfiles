local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local conform = require("conform")
local lint = require("lint")
local cmp = require("cmp")
local luasnip = require("luasnip")

lsp_zero.on_attach(function(_, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr, exclude = { "<F2>", "<F3>", "<F4>" } })

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr, silent = true })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = bufnr, silent = true })
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Diagnostic Float", silent = true })
end)

lsp_zero.set_sign_icons({ error = "✘", warn = "▲", hint = "⚑", info = "»" })

require("typescript-tools").setup({
	settings = {
		tsserver_file_preferences = { importModuleSpecifierPreference = "non-relative" },
		expose_as_code_action = "all",
	},
})

vim.diagnostic.config({ float = { border = "rounded" } })

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("javascript", { "html", "javascriptreact" })

---@diagnostic disable-next-line: missing-fields
require("mason-lspconfig").setup({
	automatic_installation = true,
	handlers = {
		function(server_name) lspconfig[server_name].setup({}) end,

		["tailwindcss"] = function()
			lspconfig["tailwindcss"].setup({
				settings = { tailwindCSS = { experimental = { classRegex = { { "([a-zA-Z0-9\\-:]+)" } } } } },
			})
		end,
	},
})

cmp.setup({
	completion = { completeopt = "menu,menuone,noinsert" }, -- auto highlight first item
	snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({ ["<CR>"] = cmp.mapping.confirm({ select = true }) }),
	sources = {
		{ name = "emmet" }, -- emmet
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	},
	formatting = {
		format = require("lspkind").cmp_format({
			before = require("tailwind-tools.cmp").lspkind_format,
			mode = "symbol",
			symbol_map = { Codeium = "" },
			show_labelDetails = true,
		}),
	},
})

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
		markdown = { "prettier" },
		toml = { "taplo" },
		sh = { "beautysh" },
		zsh = { "beautysh" },
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

vim.keymap.set({ "n", "v" }, "<leader>lf", conform.format, { desc = "LSP Format" })

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

lint.linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	javascriptreact = { "eslint" },
	typescriptreact = { "eslint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function() lint.try_lint() end,
})
