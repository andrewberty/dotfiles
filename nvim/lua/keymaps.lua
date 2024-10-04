local map = vim.keymap.set

map("i", "jj", "<ESC>", { desc = "Exit Insert Mode", silent = true })
map("i", "jk", "<ESC>", { desc = "Exit Insert Mode", silent = true })

map("v", "w", "E", { desc = "Move to end of the word w/o whitespace", silent = true })

map("n", "<tab>", ":bnext<CR>", { desc = "Next Buffer", silent = true })
map("n", "<S-tab>", ":bprevious<CR>", { desc = "Previous Buffer", silent = true })

map("n", "<leader>x", ":bp|bd #<CR>", { desc = "Delete Buffer", silent = true })

map("n", "<S-down>", ":m .+1<CR>==", { desc = "Move Line Down", silent = true })
map("n", "<S-up>", ":m .-2<CR>==", { desc = "Move Line Up", silent = true })
map("v", "<S-down>", ":m '>+1<CR>gv=gv", { desc = "Move Line Down", silent = true })
map("v", "<S-up>", ":m '<-2<CR>gv=gv", { desc = "Move Line Up", silent = true })

map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear Highlighting", silent = true })
map("n", "<leader>i", ":IBLToggle<CR>", { desc = "Toggle Indentation", silent = true })
map("n", "<leader>l", ":set number!<CR>", { desc = "Toggle Line Numbers", silent = true })

map("n", "q", ":q<CR>", { desc = "Quit window", silent = true })
map("n", "<leader>a", "ggVG", { desc = "Select All", silent = true })

map("n", "+", ":vertical resize +1<CR>", { desc = "Increase Split Width", silent = true })
map("n", "_", ":vertical resize -1<CR>", { desc = "Decrease Split Width", silent = true })
map("n", "=", ":resize +1<CR>", { desc = "Increase Split Height", silent = true })
map("n", "-", ":resize -1<CR>", { desc = "Decrease Split Height", silent = true })

map("n", "<C-d>", "<C-d>zz", { desc = "Keep Cursor Centered While Scrolling", silent = true })
map("n", "<C-u>", "<C-u>zz", { desc = "Keep Cursor Centered While Scrolling", silent = true })

map("v", "y", "y`]", { desc = "Place Cursor at End After Yanking", silent = true })
map("n", "yy", "yy`]", { desc = "Place Cursor at End After Yanking", silent = true })
map("v", "p", '"_dp`]', { desc = "Paste Without Yanking", silent = true })
map("n", "p", "p`]", { desc = "Paste Without Yanking", silent = true })
map({ "n", "v" }, "d", '"_d', { desc = "Delete Without Yanking", silent = true })
map({ "n", "v" }, "c", '"_c', { desc = "Change Without Yanking", silent = true })
map("n", "<CR>", '"_ciw', { desc = "Change Word on Enter", silent = true })

map({ "n", "v" }, "<down>", "gj", { desc = "Move down to visible line", silent = true })
map({ "n", "v" }, "<up>", "gk", { desc = "Move up to visible line", silent = true })
map("i", "<down>", "<ESC>gji", { desc = "Move down to visible line", silent = true })
map("i", "<up>", "<ESC>gki", { desc = "Move up to visible line", silent = true })

map({ "n", "v" }, "X", "Vx", { desc = "Cut Current Line", silent = true })
map({ "n", "v" }, "<leader>so", ":so %<CR>", { desc = "Source current file", silent = true })
map({ "n", "v" }, "<C-s>", ":w!<CR>", { desc = "Save", silent = true })
map({ "n", "v" }, "<leader>v", ":vsp<CR>", { desc = "Vertical Split", silent = true })
