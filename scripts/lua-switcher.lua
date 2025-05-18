local M = {}

M.lines_store = {}
M.config_value = arg[1]
M.config_key = nil
M.line_found_and_replaced = false

M.populate_lines_from_file = function(path)
	local file_read = assert(io.open(path, "r"))

	for line in file_read:lines() do
		table.insert(M.lines_store, line)
	end

	file_read:close()
end

M.write_lines_to_file = function(path)
	local file_write = assert(io.open(path, "w"))

	if not M.line_found_and_replaced then
		table.insert(M.lines_store, M.config_key .. " = " .. M.config_value)
	end

	for _, line in ipairs(M.lines_store) do
		file_write:write(line .. "\n")
	end

	file_write:close()
end

M.key_exists = function(line, config_key)
	local pattern = config_key .. " = "
	return string.find(line, pattern, 1, true)
end

M.reload_config_file = function()
	os.execute("osascript " .. os.getenv("HOME") .. "/dotfiles/scripts/reload-ghostty.scpt")
end

function M.write_config(opts)
	M.config_key = opts.config_key
	local file_name = opts.config_file or "ghostty/dynamic-config"
	local path = os.getenv("HOME") .. "/dotfiles/" .. file_name

	if opts.prompt then
		io.write(opts.prompt .. " -> ")
		M.config_value = io.read()
	end

	M.populate_lines_from_file(path)

	for i, line in ipairs(M.lines_store) do
		if M.key_exists(line, opts.config_key) then
			M.line_found_and_replaced = true
			M.lines_store[i] = opts.config_key .. " = " .. M.config_value
			break
		end
	end

	M.write_lines_to_file(path)
	M.reload_config_file()
end

return M
