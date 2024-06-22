-- ██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗
-- ██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝
-- ██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████╗
-- ██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║
-- ██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║
-- ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝
--

local nvmap = require("config.utils").nvmap
return {
  {
    "numToStr/Navigator.nvim",
    config = function()
      vim.keymap.set({ "n", "t" }, "<A-Left>", "<CMD>NavigatorLeft<CR>")
      vim.keymap.set({ "n", "t" }, "<A-Right>", "<CMD>NavigatorRight<CR>")
      vim.keymap.set({ "n", "t" }, "<A-Up>", "<CMD>NavigatorUp<CR>")
      vim.keymap.set({ "n", "t" }, "<A-Down>", "<CMD>NavigatorDown<CR>")

      require("Navigator").setup()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    -- enabled = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<A-Left>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<A-Down>", "<cmd>TmuxNavigateDown<cr>" },
      { "<A-Up>", "<cmd>TmuxNavigateUp<cr>" },
      { "<A-Right>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB,
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = "background", -- Set the display mode.
        virtualtext = "■",
        always_update = false,
      },
    },
  },
  {
    "moll/vim-bbye",
    config = function()
      nvmap("<leader>x", "<cmd>Bdelete<cr>", { desc = "Close Buffer" })
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      nvmap("<leader>U", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undotree" })
    end,
  },
  {
    "mg979/vim-visual-multi",
    config = function()
      vim.g.VM_maps["Add Cursor Up"] = ""
      vim.g.VM_maps["Add Cursor Down"] = ""
    end,
  },
  "folke/neodev.nvim",
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  { "echasnovski/mini.ai", version = "*" },
  {
    "echasnovski/mini.move",
    enabled = false,
    version = "*",
    -- No need to copy this inside `setup()`. Will be used automatically.
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- Move current line in Normal mode
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
  },
  -- {
  --   "folke/persistence.nvim",
  --   event = "BufReadPre", -- this will only start session saving when an actual file was opened
  -- },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    "echasnovski/mini.comment",
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    },
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup({
        hooks = {
          pre = function()
            require("ts_context_commentstring.internal").update_commentstring({})
          end,
        },
      })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      nvmap("<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
        desc = "Toggle Spectre",
      })
      nvmap("<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = "Search current word",
      })
      nvmap("<leader>sp", '<cmd>lua require("spectre").open_file_search()<CR>', {
        desc = "Search on current file",
      })
    end,
  },
}
