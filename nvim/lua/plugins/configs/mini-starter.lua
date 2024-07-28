local starter = require("mini.starter")

starter.setup({
	evaluate_single = true,
	items = {
		starter.sections.recent_files(5, true, false),
		{ name = "Lazy Sync", action = "Lazy sync", section = "Commands" },
		{ name = "Find Files", action = "Telescope find_files", section = "Commands" },
		{
			name = "Config",
			action = "cd " .. vim.fn.stdpath("config") .. " || lua require('mini.starter').refresh()",
			section = "Commands",
		},
		{ name = "Quit", action = "qa", section = "Commands" },
	},
	content_hooks = {
		starter.gen_hook.adding_bullet("  "),
		starter.gen_hook.indexing("all", { "Commands" }),
		starter.gen_hook.aligning("center"),
		starter.gen_hook.padding(0, 10),
	},
	header = require("utils").logos[1],
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	callback = function()
		local stats = require("lazy").stats()
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
		starter.config.footer = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
		starter.refresh()
	end,
})
