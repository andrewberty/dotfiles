---@module 'snacks'

local ignored = require("utils").ignored_colors

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		terminal = {
			auto_close = true,
			win = { style = { border = "rounded", width = 0.7, height = 0.5 } },
		},
		bigfile = { size = 1024 * 1024 },
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
			hidden = true,
			ignored = true,
			win = { input = { border = "none", keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } } },
			matcher = { frecency = true },
			layouts = {
				default = { layout = { width = 0.95, height = 0.95 } },
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
				grep = {
					cmd = "rg",
					args = {
						"--column",
						"--line-number",
						"--no-heading",
						"--smart-case",
						"--max-columns=4096",
						"-g",
						"!{.git,node_modules,.next}",
					},
				},
				files = {
					formatters = { file = { filename_first = true } },
					cmd = "fd",
					args = {
						"--color=never",
						"--type",
						"f",
						"-H",
						"-I",
						"--follow",
						"-E",
						".git",
						"-E",
						"node_modules",
						"-E",
						".next",
						"-E",
						".DS_Store",
					},
				},
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
		{ "<leader>f", function() Snacks.picker.files() end, desc = "Smart Find Files" },
		{ "<leader>st", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },

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
		{ "<leader>jd", function() Snacks.terminal.toggle("npm run dev") end, desc = "Toggle npm dev server" },
		{ "<leader>j", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
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
