--  ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
-- ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
-- ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
-- ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
-- ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
--  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
--

return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      for key, value in pairs({
        gruvbox_material_background = "hard", -- soft, medium, hard
        gruvbox_material_foreground = "original",
        gruvbox_material_statusline_style = "original",
        gruvbox_material_disable_italic_comment = 1,
        gruvbox_material_transparent_background = 2, -- 0,1,2
        gruvbox_material_ui_contrast = "high", -- low, high
        gruvbox_material_float_style = "dim", -- bright, dim
        gruvbox_material_cursor = "orange", -- auto, red, orange, yellow, green, aqua, blue, purple
        gruvbox_material_visual = "green background", -- [grey,red,green,blue] background, reverse
        gruvbox_material_menu_selection_background = "orange", --same colors as cursor
        -- gruvbox_material_colors_override = {}
      }) do
        vim.g[key] = value
      end
      vim.cmd("autocmd ColorScheme * highlight NormalFloat guibg=NONE")
      vim.cmd("autocmd ColorScheme * highlight FloatBorder guibg=NONE")
      vim.cmd("autocmd ColorScheme * highlight TelescopeSelection guibg=NONE")
      vim.cmd("autocmd ColorScheme * highlight link TelescopePromptPrefix Orange")
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = "auto",
      extend_background_behind_borders = true,
      dark_variant = "moon",
      bold_vert_split = false,
      dim_inactive_background = false,
      styles = {
        bold = false,
        italic = false,
        transparency = true,
      },
      groups = {},
      highlight_groups = {
        WinSeparator = { fg = "overlay" },
        TelescopeSelection = { bg = "none" },
        TelescopeSelectionCaret = { bg = "none" },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      on_colors = function(colors)
        colors.bg_statusline = colors.none
      end,
      -- on_highlights = function(highlights, colors) end,
    },
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    opts = {
      background = {
        light = "latte",
        dark = "mocha",
      },
      no_italic = true,
      no_bold = true,
      no_underline = true,
      transparent_background = true,
      show_end_of_buffer = false,
      color_overrides = {
        mocha = {
          base = "#11111b",
        },
      },
      integrations = {
        cmp = true,
        mason = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        alpha = true,
        notify = false,
        noice = true,
        telescope = {
          enabled = true,
          -- style = "nvchad"
        },
        which_key = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    priority = 1000,
    config = function()
      local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "nightfly",
        callback = function()
          vim.cmd("hi clear VertSplit")
        end,
        group = custom_highlight,
      })

      for key, value in pairs({
        nightflyCursorColor = true,
        nightflyItalics = false,
        nightflyNormalFloat = true,
        nightlflyTerminalColors = true,
        nightflyTransparent = true,
        nightflyUnderCurls = true,
        nightflyUnderlineMatchParen = true,
        nightflyVirtualTextColor = false,
        nightflyWinSeparator = 0, -- 0 no separators, 1 block separators (default), 2 line separators
      }) do
        vim.g[key] = value
      end
    end,
  },
}
