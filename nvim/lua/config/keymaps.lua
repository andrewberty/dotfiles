-- ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
-- ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝
--
--
local map = require("config.utils").map

map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Selected Line Up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Selected Line Down" })
map("n", "<C-s>", ":w!<CR>", { desc = "Save" })
map("i", "jj", "<ESC>", { desc = "Exit Insert Mode" })
map("i", "jk", "<ESC>", { desc = "Exit Insert Mode" })
map({ "n", "x", "o" }, "H", "^", { desc = "To Start of Line" })
map({ "n", "x", "o" }, "L", "$", { desc = "To End of Line" })
map("n", "<tab>", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-tab>", ":bprevious<CR>", { desc = "Previous Buffer" })
map("n", "<CR>", "ciw", { desc = "Change Word" })
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear Highlighting" })
map("n", "<leader>i", ":IBLToggle<CR>", { desc = "Toggle Indentation" })
map("n", "<leader>l", ":set number! rnu!<CR>", { desc = "Toggle Line Numbers" })
map("n", "q", ":q<CR>", { desc = "Quit window" })
map("n", "<leader>a", "ggVG", { desc = "Select All" })
map("n", "<leader><Left>", ":wincmd h<CR>", { desc = "Go To Left Split" })
map("n", "<leader><Down>", ":wincmd j<CR>", { desc = "Go To Bottom Split" })
map("n", "<leader><Up>", ":wincmd k<CR>", { desc = "Go To Top Split" })
map("n", "<leader><Right>", ":wincmd l<CR>", { desc = "Go To Right Split" })
map("n", "+", ":vertical resize +1<CR>", { desc = "Increase Split Width" })
map("n", "_", ":vertical resize -1<CR>", { desc = "Decrease Split Width" })
map("n", "=", ":resize +1<CR>", { desc = "Increase Split Height" })
map("n", "-", ":resize -1<CR>", { desc = "Decrease Split Height" })
map("n", "<C-d>", "<C-d>zz", { desc = "Keep Cursor Centered While Scrolling" })
map("n", "<C-u>", "<C-u>zz", { desc = "Keep Cursor Centered While Scrolling" })
map("n", "d", '"_d', { desc = "Delete Without Yanking" })
map("n", "c", '"_c', { desc = "Change Without Yanking" })
map("v", "p", '"_dp', { desc = "Paste Without Yanking" })
