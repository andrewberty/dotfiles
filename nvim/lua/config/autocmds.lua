--  █████╗ ██╗   ██╗████████╗ ██████╗  ██████╗███╗   ███╗██████╗ ███████╗
-- ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██╔════╝████╗ ████║██╔══██╗██╔════╝
-- ███████║██║   ██║   ██║   ██║   ██║██║     ██╔████╔██║██║  ██║███████╗
-- ██╔══██║██║   ██║   ██║   ██║   ██║██║     ██║╚██╔╝██║██║  ██║╚════██║
-- ██║  ██║╚██████╔╝   ██║   ╚██████╔╝╚██████╗██║ ╚═╝ ██║██████╔╝███████║
-- ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝╚═╝     ╚═╝╚═════╝ ╚══════╝

local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", {
  command = [[set formatoptions-=cro]],
})

-- Change the working directory to the parent directory of the opened file
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "silent! lcd %:p:h",
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local cwd = vim.fn.getcwd()
    if string.find(cwd, "/more") then
      vim.cmd([[FormatDisable]])
    end
  end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

api.nvim_create_autocmd("FileType", {
  pattern = "man",
  command = [[nnoremap <buffer><silent> q :quit<CR>]],
})

-- close some filetypes with <q>
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("close_with_q", {
    clear = true,
  }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
    })
  end,
})

-- resize neovim split when terminal is resized
api.nvim_command("autocmd VimResized * wincmd =")

-- Open help window in a vertical split to the right.
api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd.wincmd("L")
    end
  end,
})
