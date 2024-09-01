local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local tailwind_tools = require("tailwind-tools")

local conform = require("conform")
local lint = require("lint")

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr, exclude = { "<F2>", "<F3>", "<F4>" } })

	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr, silent = true })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = bufnr, silent = true })
end)

lsp_zero.set_sign_icons({ error = "✘", warn = "▲", hint = "⚑", info = "»" })

tailwind_tools.setup({})

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("javascript", { "html", "javascriptreact" })

mason.setup()

mason_lspconfig.setup({
	automatic_installation = true,
	ensure_installed = { "html", "cssls", "tailwindcss", "emmet_ls", "tsserver", "lua_ls", "taplo" },
	handlers = {
		-- default handler
		function(server_name) require("lspconfig")[server_name].setup({}) end,

		-- custom handlers
		["lua_ls"] = function() lspconfig["lua_ls"].setup(lsp_zero.nvim_lua_ls()) end,
		["tailwindcss"] = function()
			lspconfig["tailwindcss"].setup({
				settings = {
					tailwindCSS = { classAttributes = { "class", "className", "class:list", "classList", "ngClass", "pt" } },
				},
			})
		end,
		["emmet_ls"] = function()
			lspconfig["emmet_ls"].setup({
				filetypes = {
					"html",
					"css",
					"sass",
					"scss",
					"vue",
					"javascriptreact",
					"typescriptreact",
					"javascript",
					"typescript",
				},
			})
		end,
	},
})

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert", -- auto highlight first item
	},
	snippet = {
		expand = function(args) luasnip.lsp_expand(args.body) end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = {
		{ name = "luasnip" }, -- snippets
		{ name = "codeium" }, -- codeium
		{ name = "nvim_lsp" },
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	},
	formatting = {
		format = lspkind.cmp_format({
			before = require("tailwind-tools.cmp").lspkind_format,
			mode = "symbol",
			symbol_map = { Codeium = "" },
			show_labelDetails = true,
		}),
	},
})

conform.setup({
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
	},
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end

		local ignore_filetypes = { "markdown" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then return end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
})

vim.keymap.set({ "n", "v" }, "<leader>lf", conform.format, { desc = "LSP Format" })

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

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
