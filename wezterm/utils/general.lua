local M = {}

M.split = function(inputstr, sep)
	if sep == nil then
		sep = "%s+" -- Default to splitting by whitespace
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

M.getDirNameFromPath = function(path)
	local parts = M.split(path, "/")
	return parts[#parts]
end

M.clamp = function(value, min, max)
	if value < min then
		return min
	elseif value > max then
		return max
	else
		return value
	end
end

return M
