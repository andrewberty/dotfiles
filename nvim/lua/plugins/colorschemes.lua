--  ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
-- ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
-- ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
-- ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
-- ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
--  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
--

return {
  {
    "RRethy/base16-nvim",
    enabled = false,
    config = function()
      require("base16-colorscheme").with_config({
        telescope = false,
        indentblankline = true,
        notify = true,
        ts_rainbow = true,
        cmp = false,
        illuminate = true,
        dapui = true,
      })
    end,
  },
  {
    "baliestri/aura-theme",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      -- vim.cmd([[colorscheme aura-dark]])
    end,
  },
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
        -- gruvbox_material_transparent_background = 2, -- 0,1,2
        gruvbox_material_ui_contrast = "high", -- low, high
        gruvbox_material_float_style = "dim", -- bright, dim
        gruvbox_material_cursor = "red", -- auto, red, orange, yellow, green, aqua, blue, purple
        gruvbox_material_visual = "red background", -- [grey,red,green,blue] background, reverse
        gruvbox_material_menu_selection_background = "red", --same colors as cursor
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
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
        -- on_highlights = function(highlights, colors) end,

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
        -- nightflyTransparent = true,
        nightflyUnderCurls = true,
        nightflyUnderlineMatchParen = true,
        nightflyVirtualTextColor = false,
        nightflyWinSeparator = 0, -- 0 no separators, 1 block separators (default), 2 line separators
      }) do
        vim.g[key] = value
      end
    end,
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bold_vert_split = false, -- use bold vertical separators
      dim_nc_background = false, -- dim 'non-current' window backgrounds
      -- disable_background = true, -- disable background
      -- disable_float_background = true, -- disable background for floats
      disable_italics = true, -- disable italics
    },
  },
}
