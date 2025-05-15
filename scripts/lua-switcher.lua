local M = {}

function M.write_config(opts)
	local firstInstance = opts.firstInstanceOnly or true
	local file_name = opts.config_file or "ghostty/dynamic-config"

	local path = os.getenv("HOME") .. "/dotfiles/" .. file_name
	local reload_script = os.getenv("HOME") .. "/dotfiles/scripts/reload-ghostty.scpt"
	local promptAnswer
	local argument = arg[1]

	if not opts.config_key then
		print("No config key provided")
		return
	end

	if opts.prompt then
		io.write(opts.prompt .. " -> ")
		promptAnswer = io.read()
	end

	local lines = {}
	local file_read = io.open(path, "r")

	if file_read then
		for line in file_read:lines() do
			table.insert(lines, line)
		end
		file_read:close()

		local line_found_and_replaced = false

		for i, line in ipairs(lines) do
			if string.find(line, opts.config_key, 1, true) then
				line_found_and_replaced = true
				if opts.prompt then
					lines[i] = opts.config_key .. " = " .. promptAnswer
				else
					lines[i] = opts.config_key .. " = " .. argument
				end

				-- replace the first occurrence only
				if firstInstance then
					break
				end
			end
		end

		if line_found_and_replaced then
			local file_write = io.open(path, "w")

			if file_write then
				for _, line in ipairs(lines) do
					file_write:write(line .. "\n")
				end
				file_write:close()
			end
		end

		os.execute("osascript " .. reload_script) -- reload ghostty
	end
end

return M
