return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("tailwind-tools").setup({
			server = {
				settings = {
					emmetCompletions = true,
					experimental = {
						classRegex = {
							-- { "([a-zA-Z0-9\\-:]+)" }, -- matches anywhere (useful for emmet expansion)
							{ "[\"`']([^\"'`]*)[\"`']" }, -- matches inside of quotes or backticks
						},
					},
				},
			},
			document_color = {
				enabled = true,
				kind = "background",
				debounce = 100,
			},
			extension = {
				patterns = {
					javascript = { "cn%(([^)]+)%)" },
					javascriptreact = { "cn%(([^)]+)%)" },
					typescript = { "cn%(([^)]+)%)" },
					typescriptreact = { "cn%(([^)]+)%)" },
				},
			},
		})

		vim.keymap.set(
			"n",
			"<leader>twc",
			":TailwindConcealToggle<CR>",
			{ noremap = true, silent = true, desc = "Tailwin Conceal Toggle" }
		)
	end,
}
