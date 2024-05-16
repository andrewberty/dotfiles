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
      for key, value in pairs({
        gruvbox_material_foreground = "material",
        gruvbox_material_transparent_background = 1, -- 0,1,2
        gruvbox_material_ui_contrast = "high", -- low, high
        gruvbox_material_float_style = "dim", -- bright, dim
        gruvbox_material_cursor = "orange", -- auto, red, orange, yellow, green, aqua, blue, purple
        gruvbox_material_visual = "green background", -- [grey,red,green,blue] background, reverse
        gruvbox_material_menu_selection_background = "orange", --same colors as cursor
      }) do
        vim.g[key] = value
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "gruvbox-material",
        callback = function()
          vim.cmd([[hi NormalFloat guibg=none]])
          vim.cmd([[hi FloatBorder guibg=none guifg='#292929']])
          vim.cmd([[hi TelescopeSelection guibg=none]])
          vim.cmd([[hi link TelescopeBorder FloatBorder]])
        end,
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      variant = "auto",
      extend_background_behind_borders = true,
      dim_inactive_windows = false,
      dark_variant = "moon",
      bold_vert_split = false,
      styles = {
        bold = false,
        transparency = true,
      },
      highlight_groups = {
        WinSeparator = { fg = "overlay" },
        TelescopeNormal = { bg = "Normal" },
        FloatBorder = { fg = "overlay" },
        TelescopeBorder = { fg = "overlay", bg = "none" },
        TelescopeSelection = { bg = "Normal" },
        TelescopeSelectionCaret = { bg = "Normal" },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      local bg = "#011628"
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"

      require("tokyonight").setup({
        transparent = true,
        styles = {
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
        on_highlights = function(highlights, colors)
          highlights.TelescopeSelection = { bg = colors.none }
        end,

        on_colors = function(colors)
          colors.bg_statusline = colors.none

          colors.bg = bg
          colors.bg_highlight = bg_highlight
          colors.bg_search = bg_search
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
      })
    end,
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
      no_bold = true,
      no_underline = true,
      transparent_background = false,
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
      for key, value in pairs({
        nightflyCursorColor = true,
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

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "nightfly",
        callback = function()
          vim.cmd([[hi VertSplit guibg=none]])
          vim.cmd([[hi TelescopeSelection guibg=none]])
        end,
      })
    end,
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bold_vert_split = false, -- use bold vertical separators
      dim_nc_background = false, -- dim 'non-current' window backgrounds
      disable_background = true, -- disable background
      disable_float_background = true, -- disable background for floats
    },
  },
  {
    "embark-theme/vim",
    as = "embark",
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "embark",
        callback = function()
          vim.cmd([[hi Normal guibg=none]])
          vim.cmd([[hi NormalFloat guibg=none]])
          vim.cmd([[hi FloatBorder guibg=none]])
        end,
      })
    end,
  },
}
