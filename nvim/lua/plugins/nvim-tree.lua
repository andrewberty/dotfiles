-- ███╗   ██╗██╗   ██╗██╗███╗   ███╗   ████████╗██████╗ ███████╗███████╗
-- ████╗  ██║██║   ██║██║████╗ ████║   ╚══██╔══╝██╔══██╗██╔════╝██╔════╝
-- ██╔██╗ ██║██║   ██║██║██╔████╔██║█████╗██║   ██████╔╝█████╗  █████╗
-- ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║╚════╝██║   ██╔══██╗██╔══╝  ██╔══╝
-- ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║      ██║   ██║  ██║███████╗███████╗
-- ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝      ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝
--
--
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  -- enabled = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>e",
      ":NvimTreeToggle<CR>",
      { noremap = true, silent = true, desc = "Nvim Tree Toggle" }
    )
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      filters = {
        git_ignored = false,
      },
      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = {
          min = 20,
          max = -1,
        },
        -- hide_root_folder = true,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },

      renderer = {
        root_folder_label = false,
        indent_width = 1,
        highlight_git = false,
        icons = {
          glyphs = {
            folder = {
              -- arrow_closed = icons.ui.TriangleShortArrowRight, -- arrow when folder is closed
              arrow_closed = "", -- arrow when folder is closed
              -- arrow_open = icons.ui.TriangleShortArrowDown,    -- arrow when folder is open
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            enable = false,
          },
        },
      },
    })
  end,
}
