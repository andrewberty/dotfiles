local M = {}

M.globalsPath = os.getenv("HOME") .. "/dotfiles/wezterm/globals.lua"

function M.readLuaObject(filePath)
	local file = assert(loadfile(filePath))
	return file()
end

function M.writeLuaObject(filePath, luaObject)
	local function tableToString(tbl, indent)
		indent = indent or ""
		local result = "{\n"
		local nextIndent = indent .. "  "
		for k, v in pairs(tbl) do
			local keyStr
			if type(k) == "string" and k:match("^%a[%w_]*$") then
				keyStr = k -- Use key as-is without brackets if it's a valid identifier
			else
				keyStr = "[" .. tostring(k) .. "]"
			end

			if type(v) == "table" then
				result = result .. nextIndent .. keyStr .. " = " .. tableToString(v, nextIndent) .. ",\n"
			else
				local valueStr = (type(v) == "string") and '"' .. v .. '"' or tostring(v)
				result = result .. nextIndent .. keyStr .. " = " .. valueStr .. ",\n"
			end
		end
		result = result .. indent .. "}"
		return result
	end

	local file = assert(io.open(filePath, "w"))
	file:write("return " .. tableToString(luaObject) .. "\n")
	file:close()
end

return M
