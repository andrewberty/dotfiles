-- ████████╗███████╗██╗     ███████╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
-- ╚══██╔══╝██╔════╝██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
--    ██║   █████╗  ██║     █████╗  ███████╗██║     ██║   ██║██████╔╝█████╗
--    ██║   ██╔══╝  ██║     ██╔══╝  ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝
--    ██║   ███████╗███████╗███████╗███████║╚██████╗╚██████╔╝██║     ███████╗
--    ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝
--
--
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jvgrootveld/telescope-zoxide",
      "nvim-tree/nvim-web-devicons",
      "andrew-george/telescope-themes",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "mfussenegger/nvim-dap",
      "sharkdp/fd",
    },
    opts = {
      defaults = {
        layout_config = {
          horizontal = {
            width = 0.95,
            preview_width = 0.7,
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      local map = require("config.utils").map

      map({ "n", "v" }, "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
      map({ "n", "v" }, "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Find highlight groups" })
      map({ "n", "v" }, "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
      map({ "n", "v" }, "<leader>so", "<cmd>Telescope oldfiles<cr>", { desc = "Open Recent File" })
      map({ "n", "v" }, "<leader>sR", "<cmd>Telescope registers<cr>", { desc = "Registers" })
      map({ "n", "v" }, "<leader>st", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
      map({ "n", "v" }, "<leader>sT", "<cmd>Telescope grep_string<cr>", { desc = "Grep String" })
      map({ "n", "v" }, "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
      map({ "n", "v" }, "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
      map({ "n", "v" }, "<leader>sl", "<cmd>Telescope resume<cr>", { desc = "Resume last search" })
      map({ "n", "v" }, "<leader>sc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
      map({ "n", "v" }, "<leader>sB", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
      map({ "n", "v" }, "<leader>ss", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
      map({ "n", "v" }, "<leader>sS", "<cmd>Telescope git_stash<cr>", { desc = "Git stash" })
      map({ "n", "v" }, "<leader>sz", "<cmd>Telescope zoxide list<cr>", { desc = "Zoxide" })
      map({ "n", "v" }, "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      map({ "n", "v" }, "<leader>v", "<cmd>vsplit | Telescope find_files<cr>", { desc = "Vertical Split" })
      map({ "n", "v" }, "<leader>h", "<cmd>split | Telescope find_files<cr>", { desc = "Horizontal Split" })
      map({ "n", "v" }, "<leader>lR", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
      map({ "n", "v" }, "<leader>lw", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
      map({ "n", "v" }, "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search in Buffer" })
      map({ "n", "v" }, "<leader>th", "<cmd>Telescope themes<cr>", { desc = "Theme switcher" })

      telescope.load_extension("ui-select")
      telescope.load_extension("zoxide")
      telescope.load_extension("themes")
      telescope.load_extension("dap")
    end,
  },
}
