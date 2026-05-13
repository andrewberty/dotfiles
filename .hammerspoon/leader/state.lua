-- leader.state — shared mutable state for the leader module.
--
-- This is intentionally a singleton: all submodules read and write here.
-- The alternative (threading state through every function) was noisier with
-- no real benefit, since the user only ever runs one leader at a time.

local M = {
	-- config table passed to leader.setup()
	config = nil,
	-- the top-level hs.hotkey handle (so we can rebind on reload)
	leaderHotkey = nil,
	-- list of hs.hotkey.modal instances for the active chain (one per layer)
	activeModals = nil,

	-- lifecycle flags
	modalActive = false, -- any modal currently entered
	descending = false, -- the next press is a sublayer descent, not a fresh open
	leaderHeld = false, -- physical leader key is currently down
	actionFired = false, -- a top-level action fired during the current hold

	-- timers / canvases
	previousHelperCanvas = nil,
	pendingHelperTimer = nil,
	idleTimer = nil,
}

function M.cancelPendingHelper()
	if M.pendingHelperTimer then
		M.pendingHelperTimer:stop()
		M.pendingHelperTimer = nil
	end
end

function M.cancelIdleTimer()
	if M.idleTimer then
		M.idleTimer:stop()
		M.idleTimer = nil
	end
end

function M.exitAllModals()
	if M.activeModals then
		for _, m in pairs(M.activeModals) do
			m:exit()
		end
	end
end

return M
