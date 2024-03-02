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
      -- "nvim-telescope/telescope-dap.nvim",
      -- "mfussenegger/nvim-dap",
      "sharkdp/fd",
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            width = 0.95,
            preview_width = 0.7,
          },
        },
      },
      extensions = {
        themes = {
          layout_config = {
            horizontal = {
              width = 0.8,
              height = 0.7,
            },
          },
          enable_previewer = true,
          enable_live_preview = true,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      local nvmap = require("config.utils").nvmap

      nvmap("<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
      nvmap("<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Find highlight groups" })
      nvmap("<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
      nvmap("<leader>so", "<cmd>Telescope oldfiles<cr>", { desc = "Open Recent File" })
      nvmap("<leader>sR", "<cmd>Telescope registers<cr>", { desc = "Registers" })
      nvmap("<leader>st", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
      nvmap("<leader>sT", "<cmd>Telescope grep_string<cr>", { desc = "Grep String" })
      nvmap("<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
      nvmap("<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
      nvmap("<leader>sl", "<cmd>Telescope resume<cr>", { desc = "Resume last search" })
      nvmap("<leader>sc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
      nvmap("<leader>sB", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
      nvmap("<leader>ss", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
      nvmap("<leader>sS", "<cmd>Telescope git_stash<cr>", { desc = "Git stash" })
      nvmap("<leader>sz", "<cmd>Telescope zoxide list<cr>", { desc = "Zoxide" })
      nvmap("<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      nvmap("<leader>v", "<cmd>vsplit | Telescope find_files<cr>", { desc = "Vertical Split" })
      nvmap("<leader>h", "<cmd>split | Telescope find_files<cr>", { desc = "Horizontal Split" })
      nvmap("<leader>lR", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
      nvmap("<leader>lw", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
      nvmap("<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search in Buffer" })
      nvmap("<leader>th", "<cmd>Telescope themes<cr>", { desc = "Theme switcher" })

      telescope.load_extension("ui-select")
      telescope.load_extension("zoxide")
      telescope.load_extension("themes")
      -- telescope.load_extension("dap")
    end,
  },
}
