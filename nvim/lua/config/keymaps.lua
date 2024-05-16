-- ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
-- ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝
--
--
local nmap = require("config.utils").nmap
local vmap = require("config.utils").vmap
local nvmap = require("config.utils").nvmap
local imap = require("config.utils").imap

imap("jj", "<ESC>", { desc = "Exit Insert Mode" })
imap("jk", "<ESC>", { desc = "Exit Insert Mode" })

nvmap("<C-s>", ":w!<CR>", { desc = "Save" })

nvmap("H", "^", { desc = "To Start of Line" })
nvmap("L", "$", { desc = "To End of Line" })

nmap("<tab>", ":bnext<CR>", { desc = "Next Buffer" })
nmap("<S-tab>", ":bprevious<CR>", { desc = "Previous Buffer" })

nmap("<leader>nh", ":nohl<CR>", { desc = "Clear Highlighting" })

nmap("<leader>i", ":IBLToggle<CR>", { desc = "Toggle Indentation" })
nmap("<leader>l", ":set number!<CR>", { desc = "Toggle Line Numbers" })

nmap("q", ":q<CR>", { desc = "Quit window" })
nmap("<leader>a", "ggVG", { desc = "Select All" })

nmap("+", ":vertical resize +1<CR>", { desc = "Increase Split Width" })
nmap("_", ":vertical resize -1<CR>", { desc = "Decrease Split Width" })
nmap("=", ":resize +1<CR>", { desc = "Increase Split Height" })
nmap("-", ":resize -1<CR>", { desc = "Decrease Split Height" })

nmap("<C-d>", "<C-d>zz", { desc = "Keep Cursor Centered While Scrolling" })
nmap("<C-u>", "<C-u>zz", { desc = "Keep Cursor Centered While Scrolling" })

vmap("<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Selected Line Up" })
vmap("<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Selected Line Down" })

vmap("p", '"_dp', { desc = "Paste Without Yanking" })
nvmap("d", '"_d', { desc = "Delete Without Yanking" })
nvmap("c", '"_c', { desc = "Change Without Yanking" })
nvmap("X", "Vx", { desc = "Cut Current Line" })

-- nvmap("<leader>tr", function()
--   vim.cmd("highlight Normal guibg=NONE")
-- end, { desc = "Transparent" })
