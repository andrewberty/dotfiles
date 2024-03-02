-- ██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗
-- ██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝
-- ██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████╗
-- ██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║
-- ██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║
-- ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝
--

local nvmap = require("config.utils").nvmap
return {
  "norcalli/nvim-colorizer.lua",
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
  "mg979/vim-visual-multi",
  "folke/neodev.nvim",
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<C-Left>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-Down>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-Up>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-Right>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
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
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
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
