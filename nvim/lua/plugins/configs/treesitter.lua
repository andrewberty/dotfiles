require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	auto_install = true,
	ignore_install = { "tmux" },
	textobjects = {
		select = {
			enable = true,
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = { query = "@function.outer", desc = "around a function" },
				["if"] = { query = "@function.inner", desc = "inner part of a function" },
				["ac"] = { query = "@class.outer", desc = "around a class" },
				["ic"] = { query = "@class.inner", desc = "inner part of a class" },
				["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
				["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
				["al"] = { query = "@loop.outer", desc = "around a loop" },
				["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
				["ap"] = { query = "@parameter.outer", desc = "around parameter" },
				["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
			},
			include_surrounding_whitespace = false,
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_previous_start = {
				["[f"] = { query = "@function.outer", desc = "Previous function" },
				["[c"] = { query = "@class.outer", desc = "Previous class" },
				["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
			},
			goto_next_start = {
				["]f"] = { query = "@function.outer", desc = "Next function" },
				["]c"] = { query = "@class.outer", desc = "Next class" },
				["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
			},
		},
		swap = {
			enable = false,
		},
	},
})

local parsers = require("nvim-treesitter.parsers").get_parser_configs()

parsers.blade = {
	install_info = {
		url = "https://github.com/EmranMR/tree-sitter-blade",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "blade",
}

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})
