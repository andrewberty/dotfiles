#!/opt/homebrew/bin/lua

local u = dofile(os.getenv("HOME") .. "/dotfiles/wezterm/utils.lua")

local lua = u.readLuaObject(u.globalsPath)
lua.colorscheme = tostring(arg[1])
u.writeLuaObject(u.globalsPath, lua)

print(lua.colorscheme)
