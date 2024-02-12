--  ██████╗ ██╗      █████╗ ███╗   ██╗ ██████╗███████╗
-- ██╔════╝ ██║     ██╔══██╗████╗  ██║██╔════╝██╔════╝
-- ██║  ███╗██║     ███████║██╔██╗ ██║██║     █████╗
-- ██║   ██║██║     ██╔══██║██║╚██╗██║██║     ██╔══╝
-- ╚██████╔╝███████╗██║  ██║██║ ╚████║╚██████╗███████╗
--  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝
--
--
return {
  "dnlhc/glance.nvim",
  enabled = false,
  opts = {
    theme = {
      enable = true,
      mode = "auto",
    },
    border = {
      enable = false,
      top_char = "─",
      bottom_char = "─",
    },
  },
  keys = {
    { "gD", "<CMD>Glance definitions<CR>", desc = "Glance definitions" },
    { "gR", "<CMD>Glance references<CR>", desc = "Glance references" },
    { "gY", "<CMD>Glance type_definitions<CR>", desc = "Glance type_definitions" },
    { "gM", "<CMD>Glance implementations<CR>", desc = "Glance implementations" },
  },
}
