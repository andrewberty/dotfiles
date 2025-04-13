return {
	"saghen/blink.cmp",
	event = { "InsertEnter" },
	dependencies = { "L3MON4D3/LuaSnip" },
	version = "*",
	config = function()
		require("blink.cmp").setup({
			completion = {
				menu = {
					border = "rounded",
					winhighlight = "FloatBorder:FloatBorder",
					scrollbar = false,
					draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } } },
				},

				documentation = {
					auto_show_delay_ms = 0,
					window = { winhighlight = "FloatBorder:FloatBorder", border = "rounded" },
					auto_show = true,
					treesitter_highlighting = true,
				},

				list = { selection = { preselect = true, auto_insert = false } },
			},
			fuzzy = { use_frecency = false },
			keymap = {
				preset = "enter",
				-- ["<tab>"] = {}
			},
			snippets = { preset = "luasnip" },
			cmdline = { enabled = false },
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "lazydev" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		})
	end,
}
