vim.keymap.set({ "n", "v" }, "<leader>e", ":NvimTreeToggle<CR>", { desc = "Nvim Tree Toggle", silent = true })

require("nvim-tree").setup({
  filters = {
    git_ignored = false,
    custom = { ".DS_Store" },
  },
  view = {
    centralize_selection = false,
    cursorline = true,
    debounce_delay = 15,
    width = {
      min = 20,
      max = -1,
    },
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },

  renderer = {
    root_folder_label = ":t",
    indent_width = 2,
    highlight_git = false,
    indent_markers = {
      enable = true,
    },
  },
  actions = {
    change_dir = {
      enable = true,
      global = true,
    },
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = false,
      },
    },
  },
  ui = {
    confirm = {
      default_yes = true,
    },
  },
})
