local path = os.getenv("HOME") .. "/dotfiles/ghostty/dynamic-config"
local reload_script = os.getenv("HOME") .. "/dotfiles/scripts/reload-ghostty.scpt"

local config_key = "font-family"

local lines = {}
local file_read = io.open(path, "r")

if file_read then
	for line in file_read:lines() do
		table.insert(lines, line)
	end
	file_read:close()

	local line_found_and_replaced = false

	for i, line in ipairs(lines) do
		if string.find(line, config_key, 1, true) then
			line_found_and_replaced = true
			lines[i] = config_key .. " = " .. arg[1]
			break -- always replace the first occurrence
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

	print(arg[1])
	os.execute("osascript " .. reload_script) -- reload ghostty
end
