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
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
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
    "christoomey/vim-tmux-navigator",
    lazy = false,
    enabled = false,
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
