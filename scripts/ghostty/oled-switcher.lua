local path = os.getenv("HOME") .. "/dotfiles/ghostty/oled"
local reload_script = os.getenv("HOME") .. "/dotfiles/scripts/reload-ghostty.scpt"

local config_key = "background"

local line
local file_read = io.open(path, "r")

if file_read then
	line = file_read:read("*a")
	file_read:close()

	if line == nil or line == "" then
		local file_write = io.open(path, "w")

		if file_write then
			file_write:write(config_key .. " = 000000")
			file_write:close()
		end
	else
		local file_write = io.open(path, "w")

		if file_write then
			file_write:write("")
			file_write:close()
		end
	end

	os.execute("osascript " .. reload_script) -- reload ghostty
end
