-- leader.actions — action builders for keymap values.
--
-- Each builder returns a table { fn = <callable>, label = <string> } that
-- the modal builder recognizes as a leaf binding.

local utils = require("leader.utils")

local M = {}

-- Wrap an arbitrary callable with a display label.
function M.fn(callable, label)
	return { fn = callable, label = label or "fn" }
end

-- Toggle-launch: if the frontmost app matches the target, hide it; otherwise
-- launch/focus.
function M.launch(appName, label)
	return M.fn(function()
		local matches, front = utils.frontIs(appName)
		if matches then
			utils.hideFront(front)
		else
			hs.application.launchOrFocus(appName)
		end
	end, label or appName)
end

-- Toggle-open a path in Finder. If Finder is frontmost, hide it; otherwise
-- open the path (which brings up Finder with that folder).
function M.finder(path, label)
	local expanded = utils.expandTilde(path)
	return M.fn(function()
		local matches, front = utils.frontIs("Finder")
		if matches then
			utils.hideFront(front)
		else
			os.execute(string.format('open "%s"', expanded))
		end
	end, label or path)
end

-- Run an arbitrary shell command. Backgrounded so it doesn't block the
-- modal callback.
function M.cmd(shellCmd, label)
	return M.fn(function()
		os.execute(shellCmd .. " &")
	end, label or shellCmd)
end

-- "cmd 1" or "cmd shift 4" etc — last whitespace-separated token is the key,
-- everything before it is modifiers.
function M.shortcut(keyspec, label)
	return M.fn(function()
		local parts = {}
		for p in keyspec:gmatch("%S+") do
			table.insert(parts, p)
		end
		local key = table.remove(parts)
		hs.eventtap.keyStroke(parts, key)
	end, label or keyspec)
end

-- Open any URL or file path via the system handler. Covers raycast://
-- deep-links, https://, file://, etc.
--
-- Second arg may be a label string, or an options table:
--   leader.url("https://example.com", "Example")
--   leader.url("raycast://...", { label = "right-half", background = true })
--
-- background = true adds the `-g` flag, telling macOS to handle the URL
-- without bringing the receiving app to the foreground. Needed for some
-- Raycast window-management commands that operate on the focused window.
function M.url(u, opts)
	local label, background = u, false
	if type(opts) == "string" then
		label = opts
	elseif type(opts) == "table" then
		label = opts.label or u
		background = opts.background == true
	end
	return M.fn(function()
		os.execute(string.format('open %s"%s"', background and "-g " or "", u))
	end, label)
end

-- Type a literal string at the current cursor.
function M.text(str, label)
	return M.fn(function()
		hs.eventtap.keyStrokes(str)
	end, label or str)
end

-- Mark a sub-keymap as a nested layer with its own label for the helper.
function M.layer(label, keys)
	return { keys = keys, label = label }
end

return M
