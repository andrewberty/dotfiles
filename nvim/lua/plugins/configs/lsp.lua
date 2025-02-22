local lspconfig = require("lspconfig")
local conform = require("conform")
local lint = require("lint")
local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local luasnip = require("luasnip")

local lspconfig_defaults = lspconfig.util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, cmp_nvim_lsp.default_capabilities())

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

require("typescript-tools").setup({
	settings = {
		tsserver_file_preferences = { importModuleSpecifierPreference = "non-relative" },
		expose_as_code_action = "all",
	},
})

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("javascript", { "html", "javascriptreact" })

---@diagnostic disable-next-line: missing-fields
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = { "lua_ls", "gopls", "tailwindcss", "cssls", "html", "typescript-tools", "taplo" },
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
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = {
		{ name = "emmet" }, -- emmet
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	},
	---@diagnostic disable-next-line: missing-fields
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
