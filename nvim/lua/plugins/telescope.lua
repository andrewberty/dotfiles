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
    config = function()
      local telescope = require("telescope")

      telescope.load_extension("ui-select")
      telescope.load_extension("zoxide")
      telescope.load_extension("themes")
      telescope.load_extension("dap")
    end,
  },
}
