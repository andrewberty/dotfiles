require("events")

local wezterm = require("wezterm")
local colors = require("colors")
local fonts = require("fonts")
local keys = require("keys")
local globals = require("utils.globals")

local G = globals.readGlobals()

local config = wezterm.config_builder()

-- ENV
config.set_environment_variables = { PATH = "/opt/homebrew/bin:" .. os.getenv("PATH") }
-- config.default_prog = { "/bin/zsh", "-c", "~/dotfiles/scripts/tmux-attach.zsh" }

-- WINDOW
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.macos_window_background_blur = 50
config.window_background_opacity = G.opacity or 1.0
config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.front_end = "WebGpu"
config.bidi_enabled = true
config.bidi_direction = "LeftToRight"
config.max_fps = 120
config.default_cursor_style = "BlinkingBar"

-- CURSOR
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.hide_mouse_cursor_when_typing = true
config.animation_fps = 120

fonts.apply(config)
colors.apply(config)
keys.apply(config)

return config
