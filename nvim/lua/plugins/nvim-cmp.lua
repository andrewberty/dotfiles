--  ██████╗███╗   ███╗██████╗
-- ██╔════╝████╗ ████║██╔══██╗
-- ██║     ██╔████╔██║██████╔╝
-- ██║     ██║╚██╔╝██║██╔═══╝
-- ╚██████╗██║ ╚═╝ ██║██║
--  ╚═════╝╚═╝     ╚═╝╚═╝
--
--
return {
  "hrsh7th/nvim-cmp",
  -- enabled = false,
  lazy = false,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-nvim-lsp", -- lsp autocompletion

    -- "mlaursen/vim-react-snippets",

    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion

    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()
    -- require("vim-react-snippets").lazy_load()
    luasnip.filetype_extend("javascript", { "javascriptreact" })
    luasnip.filetype_extend("javascript", { "html" })

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert", -- auto highlight first item
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
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
      -- sources for autocompletion
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      },
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
          show_labelDetails = true,
          -- maxwidth = 50,
          -- ellipsis_char = "...",
        }),
      },
    })
  end,
}
