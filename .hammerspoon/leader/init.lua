-- leader — vanilla Hammerspoon leader-key module.
--
-- Public entry point. Users only need this file:
--   local leader = require("leader")
--   leader.setup({ key = "f20", keymaps = { ... }, styles = { ... } })
--
-- Internal layout:
--   leader/state.lua   — shared mutable state, timer-cancel helpers
--   leader/utils.lua   — pure helpers (tilde expansion, frontmost matching, ...)
--   leader/actions.lua — action builders (launch, finder, cmd, url, ...)
--   leader/ui.lua      — canvas-based helper popup
--   leader/modal.lua   — modal lifecycle and hold-leader behavior
--
-- Note: Lua's `require` looks for `leader.lua` first, then `leader/init.lua`.
-- This file is the latter. (Equivalent to `index.js` in Node, but spelled
-- `init.lua` by convention.)

local actions = require("leader.actions")
local modal = require("leader.modal")
local state = require("leader.state")
local ui = require("leader.ui")

local M = {}

-- Re-export every action builder so users can write `leader.launch(...)` etc.
for k, v in pairs(actions) do
	M[k] = v
end

function M.setup(cfg)
	if state.leaderHotkey then
		state.leaderHotkey:delete()
		state.leaderHotkey = nil
	end
	state.config = cfg or {}
	state.modalActive = false
	state.descending = false
	state.leaderHeld = false
	state.actionFired = false
	state.activeModals = nil
	state.cancelPendingHelper()
	state.cancelIdleTimer()
	ui.killHelper()

	local enter = modal.buildLayer(state.config.keymaps or {}, {}, true)
	state.leaderHotkey = hs.hotkey.bind("", state.config.key or "f20", enter, modal.onLeaderRelease)
end

return M
