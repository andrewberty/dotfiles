return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPost", "BufNewFile", "VeryLazy" },
	config = function()
		local theme = require("lualine.themes.auto")

		local function custom_buffer_name(buffer, context)
			-- Get parent folder name and buffer name
			local bufname = vim.api.nvim_buf_get_name(context.bufnr)
			local parentFolder = vim.fn.fnamemodify(bufname, ":h:t")

			-- Next.js matching patterns
			local patterns = {
				["index"] = "Index",
				["page"] = "Page",
				["layout"] = "Layout",
				["loading"] = "Loading",
				["not%-found"] = "Not Found",
				["error"] = "Error",
				["route"] = "Route",
				["template"] = "Template",
			}

			-- Get the base filename without extension to be account for (.js,.ts,.jsx.tsx)
			local baseName = vim.fn.fnamemodify(buffer, ":r")

			-- Match against the patterns and format accordingly
			for file, label in pairs(patterns) do
				if baseName:match("^" .. file .. "$") and parentFolder then
					return "(" .. parentFolder .. "/" .. label .. ")"
				end
			end

			-- Return original buffer name if no matches found
			return buffer
		end

		local status_sections = {
			lualine_a = { "branch" },
			lualine_b = {
				{ "buffers", symbols = { alternate_file = "" }, fmt = custom_buffer_name },
				{ "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
			},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		}

		local winbar_sections = {
			lualine_a = {
				{
					"filetype",
					colored = false,
					icon_only = true,
					padding = { left = 0, right = 0 },
				},
				{ "filename", path = 0, file_status = false },
			},
			lualine_b = { { "filename", path = 1, file_status = false, color = { fg = "#555555" } } },
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		}

		local custom_theme = function()
			local t = {}
			for key, _ in pairs(theme) do
				if key == "inactive" then
					t[key] = { a = "NonText", b = "NonText", c = "NonText" }
				else
					t[key] = { a = "Title", b = "Normal", c = "Normal", z = "Title" }
				end
			end
			return t
		end

		local ignored = { "help", "lazy", "snacks_dashboard", "NvimTree" }

		require("lualine").setup({
			options = {
				theme = custom_theme(),
				icons_enabled = true,
				section_separators = "",
				component_separators = "",
				disabled_filetypes = { statusline = ignored, winbar = ignored },
			},
			winbar = winbar_sections,
			inactive_winbar = winbar_sections,
			sections = status_sections,
			inactive_sections = status_sections,
		})
	end,
}
