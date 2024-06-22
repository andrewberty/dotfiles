-- ████████╗███████╗██╗     ███████╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
-- ╚══██╔══╝██╔════╝██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
--    ██║   █████╗  ██║     █████╗  ███████╗██║     ██║   ██║██████╔╝█████╗
--    ██║   ██╔══╝  ██║     ██╔══╝  ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝
--    ██║   ███████╗███████╗███████╗███████║╚██████╗╚██████╔╝██║     ███████╗
--    ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝
--
--
return {
  { dir = "~/code/telescope-themes" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jvgrootveld/telescope-zoxide",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      -- "andrewberty/telescope-themes",
      "sharkdp/fd",
    },
    config = function()
      local telescope = require("telescope")
      local nvmap = require("config.utils").nvmap
      local builtin_schemes = require("telescope._extensions.themes").builtin_schemes

      local ignored_schemes = vim.list_extend(builtin_schemes, {
        "catppuccin",
        "catppuccin-frappe",
        "catppuccin-latte",
        "catppuccin-macchiato",
        "rose-pine",
        "rose-pine-dawn",
        "tokyonight",
        "tokyonight-day",
      })

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", "dist", ".git" },
          path_display = { "filename_first" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              width = 0.85,
              preview_width = 0.7,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          themes = {
            layout_strategy = "vertical",
            layout_config = {
              vertical = {
                height = 0.4,
                width = 0.4,
                prompt_position = "top",
              },
              horizontal = {
                width = 0.8,
                height = 0.7,
              },
            },
            ignore = ignored_schemes,
            enable_previewer = false,
            enable_live_preview = true,
            persist = {
              enabled = true,
            },
          },
          file_browser = {
            -- theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
        },
        mappings = {
          i = {
            ["<C-h>"] = require("telescope.actions").file_split,
          },
        },
      })

      nvmap("<leader>sh", ":Telescope help_tags<cr>", { desc = "Find Help" })
      nvmap("<leader>sH", ":Telescope highlights<cr>", { desc = "Find highlight groups" })
      nvmap("<leader>so", ":Telescope oldfiles<cr>", { desc = "Open Recent File" })
      nvmap("<leader>st", ":Telescope live_grep<cr>", { desc = "Live Grep" })
      nvmap("<leader>sk", ":Telescope keymaps<cr>", { desc = "Keymaps" })
      nvmap("<leader>sC", ":Telescope commands<cr>", { desc = "Commands" })
      nvmap("<leader>sr", ":Telescope resume<cr>", { desc = "Resume last search" })
      nvmap("<leader>sz", ":Telescope zoxide list<cr>", { desc = "Zoxide" })
      nvmap("<leader>f", ":Telescope find_files<cr>", { desc = "Find Files" })
      nvmap("<leader>sf", ":Telescope current_buffer_fuzzy_find<cr>", { desc = "Search in Buffer" })
      nvmap("<leader>th", ":Telescope themes<cr>", { desc = "Theme switcher" })

      telescope.load_extension("ui-select")
      telescope.load_extension("zoxide")
      telescope.load_extension("themes")
      telescope.load_extension("file_browser")
    end,
  },
}
