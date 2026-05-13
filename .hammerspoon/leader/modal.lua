-- leader.modal — modal lifecycle: building hs.hotkey.modal layers, key
-- dispatch, hold-leader mode, idle timeout, and the release handler.

local state = require("leader.state")
local ui = require("leader.ui")
local utils = require("leader.utils")

local M = {}

-- Build (and recursively descend into) a layer. Returns an `enter` function
-- to be bound to either the top-level leader hotkey or a parent's key binding.
function M.buildLayer(layerKeys, modals, isTopLevel)
	if isTopLevel then
		state.activeModals = modals
	end
	local modal = hs.hotkey.modal.new()
	table.insert(modals, modal)
	local labels = {}

	local function armIdleTimer()
		state.cancelIdleTimer()
		if state.leaderHeld then
			return
		end
		local timeout = (state.config and state.config.idleTimeout) or 0
		if timeout > 0 then
			state.idleTimer = hs.timer.doAfter(timeout, function()
				state.cancelPendingHelper()
				modal:exit()
				ui.killHelper()
				state.idleTimer = nil
				state.modalActive = false
			end)
		end
	end

	for k, v in pairs(layerKeys) do
		local mods, key = utils.parseKey(k)
		if utils.isLayer(v) then
			labels[k] = v.label or k
			local childEnter = M.buildLayer(v.keys, modals, false)
			modal:bind(mods, key, function()
				state.cancelPendingHelper()
				state.cancelIdleTimer()
				modal:exit()
				ui.killHelper()
				state.descending = true
				-- descending breaks out of hold mode for the parent
				state.leaderHeld = false
				state.actionFired = false
				childEnter()
			end)
		elseif utils.isAction(v) then
			labels[k] = v.label
			modal:bind(mods, key, function()
				state.cancelPendingHelper()
				state.cancelIdleTimer()
				-- hold-leader mode: top-level leaf actions fire without exiting
				if isTopLevel and state.leaderHeld then
					state.actionFired = true
					v.fn()
					return
				end
				modal:exit()
				ui.killHelper()
				state.modalActive = false
				v.fn()
			end)
		end
	end

	modal:bind({}, "escape", function()
		state.cancelPendingHelper()
		state.cancelIdleTimer()
		modal:exit()
		ui.killHelper()
		state.modalActive = false
		state.leaderHeld = false
		state.actionFired = false
	end)

	return function()
		-- Re-press while open toggles off, except during a descent.
		if state.modalActive and not state.descending then
			for _, m in pairs(modals) do
				m:exit()
			end
			state.cancelPendingHelper()
			state.cancelIdleTimer()
			ui.killHelper()
			state.modalActive = false
			state.leaderHeld = false
			state.actionFired = false
			return
		end
		for _, m in pairs(modals) do
			m:exit()
		end
		modal:enter()
		state.modalActive = true
		if isTopLevel then
			state.leaderHeld = true
			state.actionFired = false
		end
		state.cancelPendingHelper()
		ui.killHelper()
		local isDescent = state.descending
		state.descending = false
		local cfg = (state.config and state.config.styles) or {}
		if cfg.enabled ~= false then
			local delay = cfg.delay or 0
			if not isDescent and delay > 0 then
				state.pendingHelperTimer = hs.timer.doAfter(delay, function()
					ui.showHelper(labels)
					state.pendingHelperTimer = nil
				end)
			else
				ui.showHelper(labels)
			end
		end
		armIdleTimer()
	end
end

-- Release handler bound to the leader hotkey's releasedFn. If the user fired
-- at least one top-level action while holding the leader, the modal closes.
-- Otherwise (pure tap or hold-without-action), the modal stays open and the
-- idle timer that was suppressed during the hold starts counting.
function M.onLeaderRelease()
	state.leaderHeld = false
	local hadAction = state.actionFired
	state.actionFired = false
	if hadAction then
		state.exitAllModals()
		state.cancelPendingHelper()
		state.cancelIdleTimer()
		ui.killHelper()
		state.modalActive = false
		return
	end
	if state.modalActive and state.config and state.config.idleTimeout and state.config.idleTimeout > 0 then
		state.cancelIdleTimer()
		state.idleTimer = hs.timer.doAfter(state.config.idleTimeout, function()
			state.cancelPendingHelper()
			state.exitAllModals()
			ui.killHelper()
			state.idleTimer = nil
			state.modalActive = false
		end)
	end
end

return M
