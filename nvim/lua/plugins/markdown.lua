return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		keys = {
			-- { "<leader>md", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
		},
		opts = {
			enabled = false,
			heading = {
				sign = false,
				width = "block",
				border = true,
				above = "-",
				below = "-",
				left_pad = 2,
				right_pad = 4,
				backgrounds = {
					"Normal",
					"Normal",
					"Normal",
					"Normal",
					"Normal",
					"Normal",
				},
			},

			code = {
				sign = false,
				language = true,
				width = "block",
				language_pad = 4,
				left_pad = 4,
				right_pad = 4,
				inline_pad = 1,
			},
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
		config = function()
			local map = vim.keymap.set

			map("n", "<leader>md", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview", silent = true })
		end,
	},
}
