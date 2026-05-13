-- leader.ui — canvas-based helper popup rendering.

local state = require("leader.state")

local M = {}

function M.killHelper()
	if state.previousHelperCanvas then
		state.previousHelperCanvas:delete()
		state.previousHelperCanvas = nil
	end
end

-- Format the per-layer "key → label" grid as a single string with newlines.
local function buildHelperString(labels)
	local cfg = (state.config and state.config.styles) or {}
	local entriesPerLine = cfg.entriesPerLine or 5
	local entryWidth = cfg.entryWidth or 20

	local sorted = {}
	for k, label in pairs(labels) do
		table.insert(sorted, { k = k, label = label })
	end
	table.sort(sorted, function(a, b)
		return a.k < b.k
	end)

	local s = ""
	for i, e in ipairs(sorted) do
		local entry = e.k .. " → " .. e.label
		if #entry > entryWidth then
			entry = entry:sub(1, entryWidth - 2) .. ".."
		else
			entry = entry .. string.rep(" ", entryWidth - #entry)
		end
		if i > 1 then
			if (i - 1) % entriesPerLine == 0 then
				s = s .. "\n"
			else
				s = s .. "  "
			end
		end
		s = s .. entry
	end
	return s
end

function M.showHelper(labels)
	local cfg = (state.config and state.config.styles) or {}
	local s = buildHelperString(labels)

	local screen = (hs.mouse.getCurrentScreen() or hs.screen.mainScreen()):frame()
	local textAttrs = {
		font = { name = cfg.textFont or "Courier", size = cfg.textSize or 20 },
		color = cfg.textColor or { white = 1, alpha = 1 },
	}
	if type(cfg.textStyle) == "table" then
		for k, v in pairs(cfg.textStyle) do
			textAttrs[k] = v
		end
	end
	local styled = hs.styledtext.new(s, textAttrs)
	local textSize = hs.drawing.getTextDrawingSize(styled)
	local pad = cfg.padding or 14
	local strokeWidth = cfg.strokeWidth or 1
	-- Grow the canvas by strokeWidth so the stroke (drawn centered on the
	-- rectangle's edge) doesn't get clipped at the canvas bounds.
	local w = math.ceil(textSize.w) + pad * 2 + strokeWidth
	local h = math.ceil(textSize.h) + pad * 2 + strokeWidth

	local atEdge = cfg.atScreenEdge or 2
	local offset = cfg.edgeOffset or 0
	local x = screen.x + (screen.w - w) / 2
	local y
	if atEdge == 1 then
		y = screen.y + offset
	elseif atEdge == 2 then
		y = screen.y + screen.h - h - offset
	else
		y = screen.y + (screen.h - h) / 2
	end

	local radius = cfg.radius or 8
	local canvas = hs.canvas.new({ x = x, y = y, w = w, h = h })
	canvas[1] = {
		type = "rectangle",
		action = "strokeAndFill",
		frame = {
			x = strokeWidth / 2,
			y = strokeWidth / 2,
			w = w - strokeWidth,
			h = h - strokeWidth,
		},
		roundedRectRadii = { xRadius = radius, yRadius = radius },
		fillColor = cfg.fillColor or { red = 0, green = 0, blue = 0, alpha = 0.7 },
		strokeColor = cfg.strokeColor or { white = 0, alpha = 1 },
		strokeWidth = strokeWidth,
	}
	canvas[2] = {
		type = "text",
		text = styled,
		frame = {
			x = pad + strokeWidth / 2,
			y = pad + strokeWidth / 2,
			w = textSize.w,
			h = textSize.h,
		},
	}
	canvas:show()
	state.previousHelperCanvas = canvas
end

return M
