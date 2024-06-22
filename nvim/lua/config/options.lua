--  ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--  ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
--
local options = {
  incsearch = true, -- make search act like search in modern browsers
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 0,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,
  updatetime = 100, -- faster completion (4000ms default)
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  number = false,
  breakindent = true,
  numberwidth = 2,
  signcolumn = "yes",
  wrap = true,
  scrolloff = 8,
  sidescrolloff = 8,
  showcmd = false, -- Don't show the command in the last line
  ruler = false,
  title = false,
  confirm = true, -- confirm to save changes before exiting modified buffer
  fillchars = { eob = " " }, -- change the character at the end of buffer
  cursorlineopt = "number", -- set the cursorline
  background = "dark",
  laststatus = 0, -- disable neovim status bar
  fixeol = false,
}

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")

-- vim.opt.shortmess:append("W")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

for k, v in pairs(options) do
  vim.opt[k] = v
end
