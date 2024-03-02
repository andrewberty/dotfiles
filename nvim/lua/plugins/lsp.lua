-- ██╗     ███████╗██████╗
-- ██║     ██╔════╝██╔══██╗
-- ██║     ███████╗██████╔╝
-- ██║     ╚════██║██╔═══╝
-- ███████╗███████║██║
-- ╚══════╝╚══════╝╚═╝
--

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        markdown = { { "stylua", "prettier" } },
        toml = { "taplo" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local nvmap = require("config.utils").nvmap

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
      })

      local on_attach = function(client, bufnr)
        nvmap("<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", buffer = bufnr })
        nvmap("<leader>ls", vim.lsp.buf.signature_help, { desc = "Display Signature Information" })
        nvmap("<leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })
        nvmap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr })
        nvmap("gD", vim.lsp.buf.declaration, { desc = "Go to Declaration", buffer = bufnr })
        nvmap("K", vim.lsp.buf.hover, { desc = "Show Documentation", buffer = bufnr })
        nvmap("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = bufnr })
        nvmap("gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references", buffer = bufnr })
        nvmap("gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions", buffer = bufnr })
        nvmap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer Diagnostics", buffer = bufnr })
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

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
      })
    end,
  },
}
