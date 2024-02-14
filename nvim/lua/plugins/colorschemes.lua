return {
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard" -- soft, medium, hard
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_statusline_style = "mix"
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_transparent_background = 2 -- 0,1,2
      vim.g.gruvbox_material_ui_contrast = "high" -- low, high
      vim.g.gruvbox_material_float_style = "dim" -- bright, dim
      vim.g.gruvbox_material_cursor = "green" -- auto, red, orange, yellow, green, aqua, blue, purple
      vim.g.gruvbox_material_visual = "green background" -- [grey,red,green,blue] background, reverse
      vim.g.gruvbox_material_menu_selection_background = "green" --same colors as cursor
      -- vim.g.gruvbox_material_colors_override = {}
      vim.cmd("autocmd ColorScheme * highlight FloatBorder guibg=NONE")
      vim.cmd("autocmd ColorScheme * highlight TelescopeSelection guibg=NONE")
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
      groups = {
        -- border = "base",
      },
      highlight_groups = {
        WinSeparator = { fg = "overlay" },
        TelescopeSelection = { bg = "none" },
        TelescopeSelectionCaret = { bg = "none" },
        --   TelescopeNormal = { bg = 'surface' },
        --   TelescopeBorder = { bg = 'surface', fg = 'surface' },
        --   TelescopePromptNormal = { bg = 'overlay' },
        --   TelescopePromptBorder = { bg = 'overlay', fg = 'overlay' },
        --   TelescopePromptTitle = { bg = 'overlay', fg = 'overlay' },
        --   TelescopePreviewTitle = { bg = 'surface' },
        --   TelescopeResultsTitle = { bg = 'surface' },
        --   FloatBorder = { fg = 'surface', bg = 'surface' },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    enabled = true,
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
        -- local bg = "#011628"
        -- local bg_dark = "#011423"
        -- local bg_highlight = "#143652"
        -- local bg_search = "#0A64AC"
        -- local bg_visual = "#275378"
        -- local fg = "#CBE0F0"
        -- local fg_dark = "#B4D0E9"
        -- local fg_gutter = "#627E97"
        -- local border = "#547998"

        colors.bg_statusline = colors.none
        --
        --   colors.bg = bg
        --   colors.bg_dark = bg
        --   colors.bg_float = bg
        --   colors.bg_highlight = bg_highlight
        --   colors.bg_popup = bg
        --   colors.bg_search = bg_search
        --   colors.bg_sidebar = bg
        --   colors.bg_visual = bg_visual
        --   colors.border = bg
        --
        --   colors.fg = fg
        --   colors.fg_dark = fg_dark
        --   colors.fg_float = fg
        --   colors.fg_gutter = fg_gutter
        --   colors.fg_sidebar = fg_dark
      end,

      -- on_highlights = function(hl, c)
      -- Telescope highlights
      -- local prompt = "#2d3149"
      -- hl.TelescopeNormal = {
      --   bg = c.bg_dark,
      --   fg = c.fg_dark,
      -- }
      -- hl.TelescopeBorder = {
      --   bg = c.bg_dark,
      --   fg = c.bg_dark,
      -- }
      -- hl.TelescopePromptNormal = {
      --   bg = prompt,
      -- }
      -- hl.TelescopePromptBorder = {
      --   bg = prompt,
      --   fg = prompt,
      -- }
      -- hl.TelescopePromptTitle = {
      --   bg = prompt,
      --   fg = prompt,
      -- }
      -- hl.TelescopePreviewTitle = {
      --   bg = c.bg_dark,
      --   fg = c.bg_dark,
      -- }
      -- hl.TelescopeResultsTitle = {
      --   bg = c.bg_dark,
      --   fg = c.bg_dark,
      -- }

      -- Remove Cursor Line
      -- hl.CursorLine = { bg = c.none }
      -- end,
    },
  },
  {
    "catppuccin/nvim",
    enabled = true,
    priority = 1000,
    name = "catppuccin",
    opts = {
      background = {
        light = "latte",
        dark = "mocha",
      },
      no_italic = true, -- Force no italic
      no_bold = true,
      no_underline = true,
      transparent_background = true,
      show_end_of_buffer = false,
      color_overrides = {
        mocha = {
          base = "#11111b",
        },
      },
      custom_highlights = function(colors)
        return {
          -- Comment = {},
        }
      end,

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
}
