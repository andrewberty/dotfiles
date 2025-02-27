return {
	{
		"echasnovski/mini.icons",
		version = false,
		config = function()
			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			vim.keymap.set({ "n", "x" }, "s", "<Nop>")
			require("mini.surround").setup({ mappings = { add = "s" } })

			vim.keymap.set(
				{ "n", "x" },
				"<leader>cn",
				"saq{saq(F(icnjkf)i,classNamejkF(",
				{ remap = true, silent = true, desc = "Surround around quotes with cn()" }
			)
		end,
	},
	{ "echasnovski/mini.ai", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },
}
