-- ██╗     ██╗   ██╗ █████╗ ██╗     ██╗███╗   ██╗███████╗
-- ██║     ██║   ██║██╔══██╗██║     ██║████╗  ██║██╔════╝
-- ██║     ██║   ██║███████║██║     ██║██╔██╗ ██║█████╗
-- ██║     ██║   ██║██╔══██║██║     ██║██║╚██╗██║██╔══╝
-- ███████╗╚██████╔╝██║  ██║███████╗██║██║ ╚████║███████╗
-- ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝
--
--
local sections = {
  lualine_a = {},
  lualine_b = { "branch" },
  lualine_c = {
    {
      "buffers",
      symbols = { alternate_file = "" },
    },
    { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
  },
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
}

return {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  opts = {
    options = {
      theme = "auto",
      icons_enabled = true,
      section_separators = "",
      component_separators = "",
      disabled_filetypes = {
        statusline = {
          "help",
          "startify",
          "dashboard",
          "neo-tree",
          "NvimTree",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Trouble",
          "alpha",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "qf",
        },
      },
    },
    sections = sections,
    inactive_sections = sections,
    extensions = { "nvim-tree", "lazy" },
  },
}
