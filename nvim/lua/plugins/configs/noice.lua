require("noice").setup({
	routes = {
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
					{ find = "%d fewer lines" },
					{ find = "%d more lines" },
				},
			},
			opts = { skip = true },
		},
	},
	views = { mini = { win_options = { winblend = 0 } } },
	messages = { view = "mini" },
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
})
