return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		keys = {
			{
				"<leader>p",
				vim.cmd.MarkdownPreview,
				noremap = true,
				buffer = true,
				desc = "[P]review Markdown",
			},
		},
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{ "MeanderingProgrammer/render-markdown.nvim", opts = {} },
}
