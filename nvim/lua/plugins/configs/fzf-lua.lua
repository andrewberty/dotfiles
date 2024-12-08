local fzf = require("fzf-lua")

fzf.setup({
	"Telescope",
	fzf_colors = { ["bg+"] = "-1" },
	winopts = {
		height = 0.95,
		width = 0.90,
		-- preview = { default = "bat", wrap = "wrap", winopts = { number = false, cursorline = false } },
	},
	fzf_opts = {
		["--pointer"] = ">",
		["--ansi"] = true,
		["--info"] = "inline-right",
		["--height"] = "100%",
		["--layout"] = "reverse",
		["--border"] = "none",
		["--highlight-line"] = true,
	},
	previewers = {
		-- bat = { theme = "base16" },
		builtin = {
			extensions = { ["png"] = { "viu" }, ["jpg"] = { "viu" } },
		},
	},
	defaults = { header = false, prompt = "❯ ", git_icons = false },
	files = {
		formatter = "path.filename_first",
		fd_opts = [[--color=never --type f -H -I --follow -E .git -E node_modules -E .next -E .DS_Store]],
		cwd_prompt = false,
	},
	grep = {
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g '!{.git,node_modules,.next}'",
	},
	colorschemes = {
		actions = {
			["enter"] = function(selected, _)
				local path = vim.fn.stdpath("config") .. "/lua/theme.lua"
				local selectedScheme = selected[1]
				local file = assert(io.open(path, "w"))

				vim.cmd("colorscheme " .. selectedScheme)
				file:write('vim.cmd("colorscheme ' .. selectedScheme .. '")')
				file:close()
			end,
		},
		winopts = { height = 0.55, width = 0.33 },
		-- ignore_patterns   = { "^delek$", "^blue$" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>sh", fzf.help_tags, { desc = "Find Help", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sH", fzf.highlights, { desc = "Find highlight groups", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>st", fzf.live_grep_native, { desc = "Live Grep", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sk", fzf.keymaps, { desc = "Keymaps", silent = true })
vim.keymap.set({ "n", "v" }, "<c-k>", fzf.commands, { desc = "Commands", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sr", fzf.resume, { desc = "Resume last search", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>f", fzf.files, { desc = "Find Files", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sf", fzf.lgrep_curbuf, { desc = "Search in Buffer", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>th", fzf.colorschemes, { desc = "Theme switcher", silent = true })
vim.keymap.set(
	"n",
	"<leader>ca",
	":FzfLua lsp_code_actions previewer=codeaction_native<CR>",
	{ desc = "Code Actions", silent = true }
)
