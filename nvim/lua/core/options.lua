local o = vim.opt
local g = vim.g

o.incsearch = true
o.backup = false
o.clipboard = "unnamedplus"
o.cmdheight = 0
o.completeopt = { "menuone", "noselect" }
o.conceallevel = 0
o.fileencoding = "utf-8"
o.hlsearch = true
o.ignorecase = true
o.mouse = ""
o.pumheight = 10
o.showmode = false
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.termguicolors = true
o.timeoutlen = 300
o.undofile = true
o.updatetime = 100
o.writebackup = false
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.number = false
o.breakindent = true
o.numberwidth = 2
o.signcolumn = "yes"
o.wrap = true
o.scrolloff = 8
o.sidescrolloff = 8
o.showcmd = false
o.ruler = false
o.title = false
o.confirm = true
o.fillchars = { eob = " " }
o.cursorlineopt = "number"
o.background = "dark"
o.laststatus = 0
o.fixeol = false
o.whichwrap:append("<>[]hl")

g.mapleader = " "
g.maplocalleader = " "
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
