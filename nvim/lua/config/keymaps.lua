-- ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
-- ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝
--
--
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Move selected line / block of text in visual mode
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- Fast saving
map("n", "<C-s>", ":w!<CR>", opts)

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- copy everything between { and } including the brackets
-- p puts text after the cursor,
-- P puts text before the cursor.
map("n", "YY", "va{Vy", opts)

-- Move line on the screen rather than by line in the file
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Exit on jj and jk
map("i", "jj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)

-- Move to start/end of line
map({ "n", "x", "o" }, "H", "^", opts)
map({ "n", "x", "o" }, "L", "$", opts)

-- Navigate buffers
map("n", "<tab>", ":bnext<CR>", opts)
map("n", "<S-tab>", ":bprevious<CR>", opts)

-- Panes resizing
map("n", "+", ":vertical resize +1<CR>")
map("n", "_", ":vertical resize -1<CR>")
map("n", "=", ":resize +1<CR>")
map("n", "-", ":resize -1<CR>")

-- Map enter to ciw in normal mode
map("n", "<CR>", "ciw", opts)
map("n", "<BS>", "ci", opts)

-- Clear Highlighting
map("n", "<leader>nh", ":nohl<CR>", opts)

-- Search Current buffer
map("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<CR>", opts)

-- Theme Switcher
map("n", "<leader>th", ":Telescope themes<CR>", opts)

-- indentation toggle
map("n", "<leader>i", ":IBLToggle<CR>", opts)

-- line number toggle
map("n", "<leader>l", ":set number! rnu!<CR>", opts)

-- Split line with X
map("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { silent = true })

-- Splits Navigation
map("n", "<leader><Left>", ":wincmd h<CR>", opts)
map("n", "<leader><Down>", ":wincmd j<CR>", opts)
map("n", "<leader><Up>", ":wincmd k<CR>", opts)
map("n", "<leader><Right>", ":wincmd l<CR>", opts)

map("n", "q", ":q<CR>", opts)

-- Insert lines above and below while mid line in insert mode
map("i", "<C-CR>", "<ESC>o", opts)
map("i", "<A-CR>", "<ESC>O", opts)

-- Select All
map("n", "<C-A>", "ggVG", opts)
