local ensure_installed = {
	"bash",
	"css",
	"diff",
	"gitcommit",
	"go",
	"graphql",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"query",
	"regex",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"vue",
	"yaml",
}

-- `main` branch has no `auto_install`: install on demand, then start.
local function ensure_and_start(buf)
	local ft = vim.bo[buf].filetype
	local lang = vim.treesitter.language.get_lang(ft)
	if not lang or vim.tbl_contains({ "tmux" }, lang) then return end

	local ts_config = require("nvim-treesitter.config")
	if vim.tbl_contains(ts_config.get_installed("parsers"), lang) then
		pcall(vim.treesitter.start, buf, lang)
		return
	end

	if not vim.tbl_contains(ts_config.get_available(), lang) then return end

	require("nvim-treesitter").install({ lang }):await(function()
		if vim.api.nvim_buf_is_valid(buf) then pcall(vim.treesitter.start, buf, lang) end
	end)
end

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	lazy = false,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
		{ "nvim-treesitter/nvim-treesitter-context", enabled = false },
		{ "windwp/nvim-ts-autotag", opts = {} },
	},
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true, include_surrounding_whitespace = false },
			move = { set_jumps = true },
		})

		local installed = require("nvim-treesitter.config").get_installed("parsers")
		local missing = vim.tbl_filter(function(lang) return not vim.tbl_contains(installed, lang) end, ensure_installed)
		if #missing > 0 then require("nvim-treesitter").install(missing) end

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args) ensure_and_start(args.buf) end,
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")

		-- stylua: ignore
		local textobjects = {
			["af"] = { "@function.outer", "around a function" },
			["if"] = { "@function.inner", "inner part of a function" },
			["ac"] = { "@class.outer", "around a class" },
			["ic"] = { "@class.inner", "inner part of a class" },
			["ai"] = { "@conditional.outer", "around an if statement" },
			["ii"] = { "@conditional.inner", "inner part of an if statement" },
			["al"] = { "@loop.outer", "around a loop" },
			["il"] = { "@loop.inner", "inner part of a loop" },
			["ap"] = { "@parameter.outer", "around parameter" },
			["ip"] = { "@parameter.inner", "inside a parameter" },
		}

		for lhs, spec in pairs(textobjects) do
			vim.keymap.set(
				{ "x", "o" },
				lhs,
				function() select.select_textobject(spec[1], "textobjects") end,
				{ desc = spec[2] }
			)
		end

		-- stylua: ignore
		local motions = {
			["]f"] = { move.goto_next_start, "@function.outer", "Next function" },
			["]c"] = { move.goto_next_start, "@class.outer", "Next class" },
			["]p"] = { move.goto_next_start, "@parameter.inner", "Next parameter" },
			["[f"] = { move.goto_previous_start, "@function.outer", "Previous function" },
			["[c"] = { move.goto_previous_start, "@class.outer", "Previous class" },
			["[p"] = { move.goto_previous_start, "@parameter.inner", "Previous parameter" },
		}

		for lhs, spec in pairs(motions) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function() spec[1](spec[2], "textobjects") end, { desc = spec[3] })
		end
	end,
}
