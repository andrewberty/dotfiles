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
      path = 3,
    },
  },
}

local template = {
  a = "Normal",
  b = "Normal",
  c = "Normal",
}

local custom_theme = {
  normal = template,
  insert = template,
  visual = template,
  replace = template,
  command = template,
  inactive = {
    a = "NonText",
    b = "NonText",
    c = "NonText",
  },
}

return {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    require("lualine").setup({
      options = {
        theme = custom_theme,
        icons_enabled = true,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {
          statusline = {
            "help",
            "NvimTree",
            "NvimTree",
            "alpha",
          },
        },
      },
      sections = sections,
      inactive_sections = sections,
      extensions = { "nvim-tree", "lazy" },
    })
  end,
}
