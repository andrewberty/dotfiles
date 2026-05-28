hs.alert("Reloaded config")

local leader = require("leader")
local utils = require("utils")
local localConfig = {}
if hs.fs.attributes(hs.configdir .. "/local.lua") then
	localConfig = require("local")
end

leader.setup({
	key = "f18",
	idleTimeout = 5,
	keymaps = {
		-- apps
		t = leader.launch("Kitty"),
		a = leader.launch("Arc"),
		o = leader.launch("Obsidian"),
		f = leader.launch("Figma"),
		s = leader.launch("Spotify"),
		y = leader.launch("Yaak"),

		-- finder
		d = leader.finder("~/Downloads"),

		-- arc pinned tabs
		g = leader.fn(function()
			utils.launchThenSendKeys("Arc", "cmd+1")
		end, "arc tab 1"),

		b = leader.fn(function()
			utils.launchThenSendKeys("Arc", "cmd+2")
		end, "arc tab 2"),

		-- raycast utils
		v = leader.url("raycast://extensions/raycast/clipboard-history/clipboard-history", "Clipboard History"),
		c = leader.url("raycast://extensions/raycast/raycast/confetti", {
			label = "confetti",
			background = true,
		}),
		e = leader.url("raycast://extensions/raycast/emoji-symbols/search-emoji-symbols", {
			label = "emoji",
			background = true,
		}),
		["`"] = leader.url("raycast://extensions/raycast/raycast-notes/raycast-notes", "notes"),

		-- window halves via raycast (background=true so the action targets
		-- the previously-focused window instead of Raycast itself)
		right = leader.url("raycast://extensions/raycast/window-management/right-half", {
			label = "right-half",
			background = true,
		}),
		left = leader.url("raycast://extensions/raycast/window-management/left-half", {
			label = "left-half",
			background = true,
		}),
		up = leader.url("raycast://extensions/raycast/window-management/top-half", {
			label = "top-half",
			background = true,
		}),
		down = leader.url("raycast://extensions/raycast/window-management/bottom-half", {
			label = "bottom-half",
			background = true,
		}),
		["return"] = leader.url("raycast://extensions/raycast/window-management/maximize", {
			label = "Maximize",
			background = true,
		}),

		-- window quarters under q layer
		q = leader.layer("window-quarters", {
			up = leader.layer("top-quarter", {
				right = leader.url("raycast://extensions/raycast/window-management/top-right-quarter", {
					label = "right-quarter",
					background = true,
				}),
				left = leader.url("raycast://extensions/raycast/window-management/top-left-quarter", {
					label = "left-quarter",
					background = true,
				}),
			}),
			down = leader.layer("bottom-quarter", {
				right = leader.url("raycast://extensions/raycast/window-management/bottom-right-quarter", {
					label = "right-quarter",
					background = true,
				}),
				left = leader.url("raycast://extensions/raycast/window-management/bottom-left-quarter", {
					label = "left-quarter",
					background = true,
				}),
			}),
		}),

		-- reload (shift+r)
		h = leader.layer("hammerspoon", {
			r = leader.fn(hs.reload, "reload"),
		}),
	},
	styles = {
		atScreenEdge = 2, -- 0 center, 1 top, 2 bottom
		edgeOffset = 16,
		delay = 0,
		padding = localConfig.padding or 20,
		radius = localConfig.radius or 12,
		strokeWidth = localConfig.strokeWidth or 3,
		fillColor = localConfig.fillColor or { alpha = 0.85, hex = "000000" },
		strokeColor = localConfig.strokeColor or { alpha = 0.5, hex = "FF5D01" },
		textColor = localConfig.textColor or { alpha = 0.8, hex = "ffffff" },
		textFont = localConfig.font or "SF Mono",
		textSize = localConfig.fontSize or 14,
		entriesPerLine = 3,
		entryWidth = 30,
		textStyle = {
			paragraphStyle = { lineSpacing = localConfig.lineSpacing or 14 },
		},
	},
})
