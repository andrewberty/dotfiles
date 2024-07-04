return {
  {
    "nvim-lualine/lualine.nvim",
    -- enabled = false,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      require("plugins.configs.lualine")
    end,
  },
  {
    "goolord/alpha-nvim",
    -- enabled = false,
    event = "VimEnter",
    config = function()
      require("plugins.configs.alpha-nvim")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    -- enabled = false,
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = { char = "┊" },
        whitespace = {},
        scope = { enabled = true },
        exclude = { filetypes = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy" } },
      })
      -- vim.cmd("IBLDisable")
    end,
  },
  {
    "folke/noice.nvim",
    -- enabled = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
            },
          },
          opts = { skip = true },
        },
      },
      views = { mini = { win_options = { winblend = 0 } } },
      messages = { view = "mini" },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    -- enabled = false,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      local icons = require("utils").icons
      require("gitsigns").setup({
        signs = {
          delete = { text = icons.ui.Triangle },
          topdelete = { text = icons.ui.Triangle },
          changedelete = { text = icons.ui.BoldLineLeft },
        },
        attach_to_untracked = true,
        current_line_blame = true,
      })
    end,
  },
}
