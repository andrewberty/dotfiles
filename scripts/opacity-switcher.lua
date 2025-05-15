local path = os.getenv("HOME") .. "/dotfiles/ghostty/dynamic-config"
local reload_script = os.getenv("HOME") .. "/dotfiles/scripts/reload-ghostty.scpt"

local config_key = "background-opacity"

local lines = {}
local file_read = io.open(path, "r")
local direction = arg[1]
local step = 0.05

if file_read then
	for line in file_read:lines() do
		table.insert(lines, line)
	end
	file_read:close()

	local line_found_and_replaced = false

	for i, line in ipairs(lines) do
		if string.find(line, config_key, 1, true) then
			line_found_and_replaced = true

			for number in string.gmatch(line, "[0-9]+%.[0-9]+") do
				local value = tonumber(number)

				if direction == "0" then
					value = 1.0
				elseif direction == "1" and value < 1.0 then
					value = value + step
				elseif direction == "-1" and value > 0.5 then
					value = value - step
				end

				lines[i] = config_key .. " = " .. value
				break -- replace the first occurrence only
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
