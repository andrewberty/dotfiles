return {
  { "imsnif/kdl.vim" },
  {
    "stevearc/conform.nvim",
    -- enabled = false,
    config = function()
      require("plugins.configs.formatting")
    end,
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
      "luckasRanarison/tailwind-tools.nvim",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      require("plugins.configs.lsp")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- version = false,
    -- enabled = false,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup({
            opts = {
              -- Defaults
              enable_close = true, -- Auto close tags
              enable_rename = true, -- Auto rename pairs of tags
              enable_close_on_slash = false, -- Auto close on trailing </
            },
            -- per_filetype = {
            --   ["html"] = {
            --     enable_close = false,
            --   },
            -- },
          })
        end,
      },
    },
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      auto_install = true,
      ignore_install = { "tmux" },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = { query = "@function.outer", desc = "around a function" },
            ["if"] = { query = "@function.inner", desc = "inner part of a function" },
            ["ac"] = { query = "@class.outer", desc = "around a class" },
            ["ic"] = { query = "@class.inner", desc = "inner part of a class" },
            ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
            ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
            ["al"] = { query = "@loop.outer", desc = "around a loop" },
            ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
            ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
            ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
          },
          include_surrounding_whitespace = false,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Previous function" },
            ["[c"] = { query = "@class.outer", desc = "Previous class" },
            ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
          },
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next function" },
            ["]c"] = { query = "@class.outer", desc = "Next class" },
            ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
          },
        },
        swap = {
          enable = false,
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
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
      require("plugins.configs.nvim-cmp")
    end,
  },
}
