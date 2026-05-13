local M = {}

M.launchThen = function(appName, callback, opts)
	opts = opts or {}
	local timeout = opts.timeout or 5
	local interval = opts.interval or 0.05
	local settle = opts.settle or 0.1
	hs.application.launchOrFocus(appName)
	local elapsed = 0
	local poller
	poller = hs.timer.doEvery(interval, function()
		elapsed = elapsed + interval
		local front = hs.application.frontmostApplication()
		local ready = front and front:name() == appName and front:focusedWindow() ~= nil
		if ready then
			poller:stop()
			hs.timer.doAfter(settle, callback)
		elseif elapsed >= timeout then
			poller:stop()
			hs.alert("launchThen: " .. appName .. " never became ready", 2)
		end
	end)
end

-- Launch (or focus) an app, then send a keystroke once it's ready.
-- chord is a "+"-separated string: "cmd+1", "cmd+shift+t", etc.
M.launchThenSendKeys = function(appName, chord, opts)
	local parts = {}
	for p in chord:gmatch("[^+]+") do
		table.insert(parts, p)
	end
	local key = table.remove(parts)
	M.launchThen(appName, function()
		hs.eventtap.keyStroke(parts, key)
	end, opts)
end

return M
