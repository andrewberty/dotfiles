vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit Insert Mode", silent = true })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert Mode", silent = true })

vim.keymap.set("v", "w", "E", { desc = "Move to end of the word w/o whitespace", silent = true })

vim.keymap.set("n", "<tab>", ":bnext<CR>", { desc = "Next Buffer", silent = true })
vim.keymap.set("n", "<S-tab>", ":bprevious<CR>", { desc = "Previous Buffer", silent = true })

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear Highlighting", silent = true })
vim.keymap.set("n", "<leader>i", ":IBLToggle<CR>", { desc = "Toggle Indentation", silent = true })
vim.keymap.set("n", "<leader>l", ":set number!<CR>", { desc = "Toggle Line Numbers", silent = true })

vim.keymap.set("n", "q", ":q<CR>", { desc = "Quit window", silent = true })
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select All", silent = true })

vim.keymap.set("n", "+", ":vertical resize +1<CR>", { desc = "Increase Split Width", silent = true })
vim.keymap.set("n", "_", ":vertical resize -1<CR>", { desc = "Decrease Split Width", silent = true })
vim.keymap.set("n", "=", ":resize +1<CR>", { desc = "Increase Split Height", silent = true })
vim.keymap.set("n", "-", ":resize -1<CR>", { desc = "Decrease Split Height", silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep Cursor Centered While Scrolling", silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep Cursor Centered While Scrolling", silent = true })

vim.keymap.set("v", "y", "y`]", { desc = "Place Cursor at End After Yanking", silent = true })
vim.keymap.set("n", "yy", "yy`]", { desc = "Place Cursor at End After Yanking", silent = true })
vim.keymap.set("v", "p", '"_dp`]', { desc = "Paste Without Yaning", silent = true })
vim.keymap.set("n", "p", "o<ESC>gP", { desc = "Paste Without Yanking", silent = true })
-- vim.keymap.set("v", "p", "gP", { desc = "Paste Without Yanking", silent = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete Without Yanking", silent = true })
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change Without Yanking", silent = true })
vim.keymap.set("n", "<CR>", "ciw", { desc = "Change Word on Enter", silent = true })

vim.keymap.set({ "n", "v" }, "<down>", "gj", { desc = "Move down to visible line", silent = true })
vim.keymap.set({ "n", "v" }, "<up>", "gk", { desc = "Move up to visible line", silent = true })
vim.keymap.set("i", "<down>", "<ESC>gji", { desc = "Move down to visible line", silent = true })
vim.keymap.set("i", "<up>", "<ESC>gki", { desc = "Move up to visible line", silent = true })

vim.keymap.set({ "n", "v" }, "X", "Vx", { desc = "Cut Current Line", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>so", ":so %<CR>", { desc = "Source current file", silent = true })
vim.keymap.set({ "n", "v" }, "<C-k>", ":Telescope commands<CR>", { desc = "Command Palette", silent = true })
vim.keymap.set({ "n", "v" }, "<C-s>", ":w!<CR>", { desc = "Save", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>v", ":vsp<CR>", { desc = "Vertical Split", silent = true })
