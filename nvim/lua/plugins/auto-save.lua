local icons = require("config.icons")
return {
  "okuuva/auto-save.nvim",
  enabled = true,
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    enabled = false, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    execution_message = {
      enabled = true,
      message = function() -- message to print on save
        return (icons.ui.Check .. " auto-saved")
      end,
      dim = 0.18, -- dim the color of `message`
      cleaning_interval = 1000, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
    },
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
      defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
    },
    condition = nil,
    write_all_buffers = false, -- write all buffers when the current one meets `condition`
    noautocmd = false, -- do not execute autocmds when saving
    debounce_delay = 500, -- delay after which a pending save is executed
  },
}
