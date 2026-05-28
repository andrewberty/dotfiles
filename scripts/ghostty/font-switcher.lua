local currentPath = debug.getinfo(1).source:match("@?(.*/)") or "./"
package.path = currentPath .. "?.lua;" .. package.path

local switcher = require("scripts.ghostty.lua-switcher")

switcher.write_config({ config_key = "font-family" })
