local sections = {
  lualine_a = { "branch" },
  lualine_b = {
    {
      "buffers",
      symbols = { alternate_file = "" },
    },
    { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
  },
  lualine_c = {},
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
  a = "Title",
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
local ignored = {
  "help",
  "NvimTree",
  "neo-tree",
  "alpha",
  "lazy",
}

require("lualine").setup({
  options = {
    theme = custom_theme,
    icons_enabled = true,
    section_separators = "",
    component_separators = "",
    disabled_filetypes = {
      statusline = ignored,
      winbar = ignored,
    },
  },
  winbar = {},
  inactive_winbar = {},
  -- sections = {},
  -- inactive_sections = {},
  sections = sections,
  inactive_sections = sections,
})
