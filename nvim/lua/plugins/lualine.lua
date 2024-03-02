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
  lualine_z = {
    {
      "filename",
      path = 4,
    },
  },
}

local template = {
  a = { bg = "none", fg = "#ffffff" },
  b = { bg = "none", fg = "#ffffff" },
  c = { bg = "none", fg = "#ffffff" },
}

local custom_theme = {
  normal = template,
  insert = template,
  visual = template,
  replace = template,
  command = template,
  inactive = {
    a = { bg = "none", fg = "#555555" },
    b = { bg = "none", fg = "#555555" },
    c = { bg = "none", fg = "#555555" },
  },
}
return {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  opts = {
    options = {
      theme = custom_theme,
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
