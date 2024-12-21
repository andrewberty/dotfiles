local fzf = require("fzf-lua")
local kulala = require("kulala")

kulala.setup({})

vim.filetype.add({ extension = { ["http"] = "http" } })

local http_file = vim.fn.getcwd() .. "/.http"

-- Function to extract HTTP requests from the .http file
local function extract_requests_from_file()
	local requests = {}

	-- Read the .http file line by line
	local file = io.open(http_file, "r")
	if not file then
		vim.notify(".http file not found in the current working directory", vim.log.levels.WARN)
		return nil
	end

	for line in file:lines() do
		if line:match("^# @name") then -- Extract request name
			table.insert(requests, line:match("^# @name%s*(.-)%s*$"))
		end
	end

	file:close()
	return requests
end

-- Function to integrate Kulala search with fzf-lua
local function kulala_fzf_global_search()
	local requests = extract_requests_from_file()
	if not requests or vim.tbl_isempty(requests) then
		vim.notify("No HTTP requests found in the .http file", vim.log.levels.WARN)
		return
	end

	-- Use fzf-lua for fuzzy finding
	fzf.fzf_exec(requests, {
		prompt = "Requests > ",
		sort = true,
		winopts = {
			height = 0.5,
			width = 0.5,
			border = "rounded",
		},
		actions = {
			["default"] = function(selected)
				if selected then
					local request_name = selected[1]
					for line_num, line in ipairs(vim.fn.readfile(http_file)) do
						if line:match("^# @name%s*" .. vim.pesc(request_name)) then
							vim.cmd("e " .. http_file) -- Open the .http file
							vim.api.nvim_win_set_cursor(0, { line_num, 0 }) -- Jump to the request
							kulala.run() -- Execute the request
							break
						end
					end
				end
			end,
		},
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "http",
	callback = function()
		vim.keymap.set(
			"n",
			"<leader><CR>",
			"<cmd>lua require('kulala').run()<cr>",
			{ noremap = true, silent = true, desc = "Execute current request" }
		)
	end,
})

vim.keymap.set(
	"n",
	"<leader>hs",
	function() kulala_fzf_global_search() end,
	{ noremap = true, silent = true, desc = "Search HTTP requests" }
)
