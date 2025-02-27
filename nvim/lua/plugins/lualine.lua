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

		local position = "bottom"
		local sections = {
			lualine_a = { "branch" },
			lualine_b = {
				{ "buffers", symbols = { alternate_file = "" }, fmt = custom_buffer_name },
				{ "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
			},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { { "filename", path = 1, file_status = false, shorting_target = 30 } },
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

		local options = {
			options = {
				theme = custom_theme(),
				icons_enabled = true,
				section_separators = "",
				component_separators = "",
				disabled_filetypes = { statusline = ignored, winbar = ignored },
			},
		}

		if position == "top" then
			require("lualine").setup(
				vim.tbl_deep_extend(
					"force",
					options,
					{ winbar = sections, inactive_winbar = sections, sections = {}, inactive_sections = {} }
				)
			)
		elseif position == "bottom" then
			require("lualine").setup(
				vim.tbl_deep_extend(
					"force",
					options,
					{ winbar = {}, inactive_winbar = {}, sections = sections, inactive_sections = sections }
				)
			)
		end
	end,
}
