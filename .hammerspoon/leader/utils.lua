-- leader.utils — pure helpers with no dependency on leader state.

local M = {}

-- pcall wrapper that returns nil on error.
function M.safeCall(f)
	local ok, v = pcall(f)
	if ok then
		return v
	end
	return nil
end

-- Expand a leading "~" or "~/" to $HOME so the path can be safely shell-quoted
-- afterwards (the shell does not expand tilde inside quotes).
function M.expandTilde(p)
	if type(p) ~= "string" then
		return p
	end
	if p == "~" then
		return os.getenv("HOME") or p
	end
	if p:sub(1, 2) == "~/" then
		return (os.getenv("HOME") or "~") .. p:sub(2)
	end
	return p
end

-- Parse a key string into (modifiers, key) for hs.hotkey.modal:bind.
--
-- Plain key:   "r"             -> {}, "r"
-- Chord:       "shift+r"       -> {"shift"}, "r"
-- Multi-mod:   "cmd+shift+a"   -> {"cmd", "shift"}, "a"
-- Special:     "escape", "f5"  -> {}, <as-is>
--
-- The last "+"-separated token is the key; everything before it is a modifier.
function M.parseKey(k)
	if type(k) ~= "string" then
		return {}, k
	end
	local parts = {}
	for p in k:gmatch("[^+]+") do
		table.insert(parts, p)
	end
	if #parts <= 1 then
		return {}, k
	end
	local key = table.remove(parts)
	return parts, key
end

-- Action / layer type guards. Used to distinguish leader.fn(...) results
-- from leader.layer(...) results in the keymap table.
function M.isLayer(t)
	return type(t) == "table" and t.keys ~= nil
end

function M.isAction(t)
	return type(t) == "table" and type(t.fn) == "function"
end

-- Returns (matches, frontApp). True if the frontmost app matches the given
-- identifier (case-insensitive name, bundle ID, or /Applications/<name>.app path).
function M.frontIs(appName)
	local front = hs.application.frontmostApplication()
	if not front then
		return false, nil
	end
	local target = appName:lower()
	local n = M.safeCall(function()
		return front:name()
	end)
	local bid = M.safeCall(function()
		return front:bundleID()
	end)
	local p = M.safeCall(function()
		return front:path()
	end)
	local matches = (n and n:lower() == target)
		or (bid and bid:lower() == target)
		or (p and p:lower() == "/applications/" .. target .. ".app")
	return matches, front
end

-- Hide the frontmost app. Falls back to a cmd+h keystroke if app:hide()
-- returns false (some apps reject the AppleScript-style hide message).
function M.hideFront(front)
	local hidden = M.safeCall(function()
		return front:hide()
	end)
	if not hidden then
		hs.eventtap.keyStroke({ "cmd" }, "h")
	end
end

return M
