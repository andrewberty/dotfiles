local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")
local tailwind_tools = require("tailwind-tools")

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = { "html", "cssls", "tailwindcss", "emmet_ls", "tsserver", "lua_ls", "taplo" },
})

mason_tool_installer.setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d",
  },
})

tailwind_tools.setup({})

local on_attach = function(client, bufnr)
  vim.keymap.set({ "n", "v" }, "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", buffer = bufnr, silent = true })
  vim.keymap.set(
    { "n", "v" },
    "<leader>ls",
    vim.lsp.buf.signature_help,
    { desc = "Display Signature Information", silent = true }
  )
  vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr, silent = true })
  vim.keymap.set(
    { "n", "v" },
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "Code Actions", buffer = bufnr, silent = true }
  )
  vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover, { desc = "Show Documentation", buffer = bufnr, silent = true })
  vim.keymap.set(
    { "n", "v" },
    "gr",
    "<cmd>Telescope lsp_references<CR>",
    { desc = "Show LSP references", buffer = bufnr, silent = true }
  )
  vim.keymap.set(
    { "n", "v" },
    "gd",
    "<cmd>Telescope lsp_definitions<CR>",
    { desc = "Show LSP definitions", buffer = bufnr, silent = true }
  )
  vim.keymap.set(
    { "n", "v" },
    "gD",
    vim.lsp.buf.declaration,
    { desc = "Go to Declaration", buffer = bufnr, silent = true }
  )
  vim.keymap.set(
    { "n", "v" },
    "<leader>D",
    "<cmd>Telescope diagnostics bufnr=0<CR>",
    { desc = "Buffer Diagnostics", buffer = bufnr }
  )
end

local capabilities =
  vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

mason_lspconfig.setup_handlers({
  -- default handler
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
  -- overrides
  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
  ["tailwindcss"] = function()
    lspconfig["tailwindcss"].setup({
      settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "class:list", "classList", "ngClass", "pt" },
        },
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
})
