---@module 'snacks'

local ignored = require("utils").ignored_colors

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		indent = {
			indent = { char = "┊", only_scope = true, only_current = true, hl = "Comment" },
			scope = { only_current = true },
			chunk = {
				enabled = true,
				only_current = true,
				priority = 200,
				hl = "SnacksIndentChunk",
				char = { corner_top = "╭", corner_bottom = "╰", horizontal = "─", vertical = "│", arrow = ">" },
			},
		},
		---@class snacks.picker.Config
		picker = {
			ignored = true,
			hidden = true,
			formatters = { file = { filename_first = true } },
			win = { input = { border = "none", keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } } },
			layouts = {
				default = { layout = { width = 0.9, height = 0.9 } },
				sidebar = {
					auto_hide = { "input" },
					layout = {
						backdrop = false,
						width = 40,
						min_width = 40,
						height = 0,
						position = "left",
						border = "none",
						box = "vertical",
						{ win = "input", height = 1, border = "none", title = "{title} {live} {flags}", title_pos = "center" },
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
					},
				},
			},
			sources = {
				explorer = { focus = "list", win = { input = { keys = { ["<Esc>"] = false } } } },
				colorschemes = {
					layout = {
						layout = {
							width = 0.4,
							height = 0.4,
						},
					},
					transform = function(item)
						for _, ignored_color in ipairs(ignored) do
							if item.text:match(ignored_color) then return false end
						end
						return true
					end,
					confirm = function(picker, item)
						picker:close()
						if item then
							picker.preview.state.colorscheme = nil

							local file = assert(io.open(vim.fn.stdpath("config") .. "/lua/theme.lua", "w"))

							file:write('vim.cmd("colorscheme ' .. item.text .. '")')
							file:close()
						end
					end,
				},
			},
		},
		---@class snacks.dashboard.Config
		dashboard = {
			formats = {
				key = function(item) return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } } end,
			},
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Recent Files", cwd = true, section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
	},
	keys = {
		{ "<leader>th", function() Snacks.picker.colorschemes() end, desc = "Custom Colorscheme" },
		-- { "<leader>f", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>f", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		{ "<leader>st", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },

		{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
		{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sm", function() Snacks.picker.man() end, desc = "Man Pages" },
		{ "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume" },

		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
		{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },

		{ "<leader>x", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		{ "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				_G.dd = function(...) Snacks.debug.inspect(...) end
				_G.bt = function() Snacks.debug.backtrace() end

				Snacks.toggle.indent():map("<leader>i")
				Snacks.toggle.option("number", { global = true }):map("<leader>l")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
