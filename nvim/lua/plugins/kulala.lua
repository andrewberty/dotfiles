return {
	"mistweaverco/kulala.nvim",
	config = function()
		local kulala = require("kulala")

		local http_file = vim.fs.find(
			function(name) return name:match("%.http$") or name:match("%.rest$") end,
			{ path = vim.fn.getcwd(), upward = true }
		)[1]

		local function search_requests()
			-- Check if we found a file
			if not http_file then
				vim.notify("No .http file found in the current working directory", vim.log.levels.WARN)
				return
			end

			local requests = {}
			-- Read the .http file
			local file_content = vim.fn.readfile(http_file)
			if not file_content or #file_content == 0 then
				vim.notify("Failed to read HTTP file or file is empty", vim.log.levels.WARN)
				return
			end

			-- Extract requests with line numbers
			for line_num, line in ipairs(file_content) do
				if line:match("^# @name") then
					local name = line:match("^# @name%s*(.-)%s*$")
					table.insert(requests, {
						text = name,
						line_num = line_num,
						file_path = http_file,
					})
				end
			end

			if vim.tbl_isempty(requests) then
				vim.notify("No HTTP requests found in the file", vim.log.levels.WARN)
				return
			end

			Snacks.picker({
				title = "HTTP Requests",
				items = requests,
				format = "text",
				layout = {
					preset = "select",
				},
				confirm = function(picker, item)
					local absolute_path = vim.fn.fnamemodify(item.file_path, ":p")

					local bufnr = vim.fn.bufadd(absolute_path)
					vim.fn.bufload(bufnr)
					vim.cmd("buffer " .. bufnr)

					vim.api.nvim_win_set_cursor(0, { item.line_num, 0 })
					vim.cmd("normal! zz")

					picker:close()

					vim.defer_fn(function() kulala.run() end, 100) -- Small delay to ensure buffer is ready
				end,
			})
		end

		kulala.setup({
			global_keymaps = {
				["Send request"] = {
					"<leader>hs",
					search_requests,
					mode = { "n", "v" },
					desc = "Search HTTP requests",
				},
				["Run current request"] = {
					"<leader><CR>",
					kulala.run,
					mode = { "n", "v" },
					ft = { "http" },
					desc = "Run current request",
				},
			},
		})
		vim.filetype.add({ extension = { ["http"] = "http" } })
	end,
}
