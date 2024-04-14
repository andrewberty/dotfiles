-- ████████╗███████╗██╗     ███████╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
-- ╚══██╔══╝██╔════╝██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
--    ██║   █████╗  ██║     █████╗  ███████╗██║     ██║   ██║██████╔╝█████╗
--    ██║   ██╔══╝  ██║     ██╔══╝  ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝
--    ██║   ███████╗███████╗███████╗███████║╚██████╗╚██████╔╝██║     ███████╗
--    ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝
--
--
return {
  { dir = "~/code/telescope-themes/" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jvgrootveld/telescope-zoxide",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      -- "andrew-george/telescope-themes",
      "sharkdp/fd",
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", "dist" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            width = 0.85,
            preview_width = 0.7,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        themes = {
          -- layout_strategy = "vertical",
          -- layout_config = {
          --   vertical = {
          --     height = 0.4,
          --     width = 0.4,
          --     prompt_position = "top",
          --   },
          --   horizontal = {
          --     width = 0.8,
          --     height = 0.7,
          --   },
          -- },
          enable_previewer = true,
          enable_live_preview = true,
          persist = {
            enabled = true,
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      local nvmap = require("config.utils").nvmap

      nvmap("<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
      nvmap("<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Find highlight groups" })
      nvmap("<leader>so", "<cmd>Telescope oldfiles<cr>", { desc = "Open Recent File" })
      nvmap("<leader>st", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
      nvmap("<leader>sT", "<cmd>Telescope grep_string<cr>", { desc = "Grep String" })
      nvmap("<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
      nvmap("<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
      nvmap("<leader>sr", "<cmd>Telescope resume<cr>", { desc = "Resume last search" })
      nvmap("<leader>sz", "<cmd>Telescope zoxide list<cr>", { desc = "Zoxide" })
      nvmap("<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      nvmap("<leader>v", "<cmd>vsplit | Telescope find_files<cr>", { desc = "Vertical Split" })
      nvmap("<leader>h", "<cmd>split | Telescope find_files<cr>", { desc = "Horizontal Split" })
      nvmap("<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search in Buffer" })
      nvmap("<leader>th", "<cmd>Telescope themes<cr>", { desc = "Theme switcher" })

      telescope.load_extension("ui-select")
      telescope.load_extension("zoxide")
      telescope.load_extension("themes")
    end,
  },
}
