local M = {}

M.key_exists = function(line, config_key)
	local pattern = config_key .. " = "
	return string.find(line, pattern, 1, true)
end

function M.write_config(opts)
	local file_name = opts.config_file or "ghostty/dynamic-config"
	local path = os.getenv("HOME") .. "/dotfiles/" .. file_name
	local reload_script = os.getenv("HOME") .. "/dotfiles/scripts/reload-ghostty.scpt"

	local value = arg[1]
	local lines = {}

	if opts.prompt then
		io.write(opts.prompt .. " -> ")
		value = io.read()
	end

	local file_read = io.open(path, "r")

	if file_read then
		for line in file_read:lines() do
			table.insert(lines, line)
		end
		file_read:close()

		local line_found_and_replaced = false

		for i, line in ipairs(lines) do
			if M.key_exists(line, opts.config_key) then
				line_found_and_replaced = true
				lines[i] = opts.config_key .. " = " .. value
				break
			end
		end

		local file_write = io.open(path, "w")

		if file_write then
			if not line_found_and_replaced then
				table.insert(lines, opts.config_key .. " = " .. value)
			end

			for _, line in ipairs(lines) do
				file_write:write(line .. "\n")
			end
			file_write:close()
		end

		os.execute("osascript " .. reload_script) -- reload ghostty
	end
end

return M
