--  ██████╗ ██╗████████╗███████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔════╝ ██║╚══██╔══╝██╔════╝██║██╔════╝ ████╗  ██║██╔════╝
-- ██║  ███╗██║   ██║   ███████╗██║██║  ███╗██╔██╗ ██║███████╗
-- ██║   ██║██║   ██║   ╚════██║██║██║   ██║██║╚██╗██║╚════██║
-- ╚██████╔╝██║   ██║   ███████║██║╚██████╔╝██║ ╚████║███████║
--  ╚═════╝ ╚═╝   ╚═╝   ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
--
--
return {
  "lewis6991/gitsigns.nvim",
  -- lazy = true,
  enabled = true,
  config = function()
    local icons = require("config.icons")
    local nvmap = require("config.utils").nvmap

    nvmap(
      "<leader>Gk",
      "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
      { desc = "Prev Hunk" }
    )
    nvmap("<leader>Gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", { desc = "Blame" })
    nvmap("<leader>Gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = "Preview Hunk" })
    nvmap("<leader>Gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = "Reset Hunk" })
    nvmap("<leader>GR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { desc = "Reset Buffer" })
    nvmap(
      "<leader>Gj",
      "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
      { desc = "Next Hunk" }
    )
    nvmap("<leader>Gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { desc = "Stage Hunk" })
    nvmap("<leader>Gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", { desc = "Undo Stage Hunk" })

    require("gitsigns").setup({
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = icons.ui.BoldLineLeft,
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = icons.ui.BoldLineLeft,
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = icons.ui.Triangle,
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = icons.ui.Triangle,
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = icons.ui.BoldLineLeft,
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      status_formatter = nil, -- Use default
      update_debounce = 200,
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = { enable = false },
    })
  end,
}
