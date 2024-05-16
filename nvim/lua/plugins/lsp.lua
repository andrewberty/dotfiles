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
    -- enabled = false,
    opts = {
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
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = false,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
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
        callback = function()
          lint.try_lint()
        end,
      })

      -- vim.keymap.set("n", "<leader>l", function()
      --   lint.try_lint()
      -- end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")
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
        ensure_installed = { "html", "cssls", "tailwindcss", "emmet_ls", "tsserver", "lua_ls", "taplo" },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "eslint_d",
        },
      })

      local on_attach = function(client, bufnr)
        nvmap("<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", buffer = bufnr })
        nvmap("<leader>ls", vim.lsp.buf.signature_help, { desc = "Display Signature Information" })
        nvmap("<leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })
        nvmap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr })
        nvmap("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = bufnr })
        nvmap("K", vim.lsp.buf.hover, { desc = "Show Documentation", buffer = bufnr })
        nvmap("gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references", buffer = bufnr })
        nvmap("gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions", buffer = bufnr })
        nvmap("gD", vim.lsp.buf.declaration, { desc = "Go to Declaration", buffer = bufnr })
        nvmap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer Diagnostics", buffer = bufnr })
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
      })
    end,
  },
}
