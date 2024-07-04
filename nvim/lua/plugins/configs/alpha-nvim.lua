local theme = "startify"
local configDir = vim.fn.stdpath("config")

if theme == "dashboard" then
  local dashboard = require("alpha.themes.dashboard")
  local logo = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]
  dashboard.section.header.val = vim.split(logo, "\n")

  -- BUTTONS
  dashboard.section.buttons.val = {
    dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("c", " " .. " Config", ":cd " .. configDir .. "<CR>"),
    dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    dashboard.button("l", " " .. " Lazy", ":Lazy<CR>"),
  }
  for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
    button.opts.width = 40
  end

  --HIGHLIGHTS
  dashboard.section.header.opts.hl = "AlphaHeader"
  dashboard.section.buttons.opts.hl = "AlphaButtons"
  dashboard.section.footer.opts.hl = "AlphaFooter"

  -- SPACING
  dashboard.opts.layout[1].val = 8
  dashboard.opts.layout[3].val = nil
  dashboard.section.buttons.opts.spacing = 1

  vim.keymap.set("n", "<leader>;", "<cmd>Alpha<cr>", { desc = "Dashboard" })
  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  require("alpha").setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
elseif theme == "startify" then
  -- STARTIFY CONFIG
  local theta = require("alpha.themes.theta")
  local dashboard = require("alpha.themes.dashboard")
  -- local logo = require("config.utils").drinks[2]

  --logo
  theta.config.layout[1].val = 4 -- top margin
  -- theta.header.val = logo

  theta.mru_opts.autocd = true
  theta.config.layout[4].val[3].val = function()
    return { theta.mru(0, vim.fn.getcwd(), 5) }
  end

  theta.buttons.val = {
    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
    { type = "padding", val = 1 },
    dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    dashboard.button("z", " " .. " Recent files", ":Telescope zoxide list <CR>"),
    dashboard.button("c", " " .. " Config", ":cd " .. configDir .. "<CR>"),
    dashboard.button("l", " " .. " Lazy", ":Lazy<CR>"),
    dashboard.button("q", " " .. " Quit", ":qa<CR>"),
  }

  require("alpha").setup(theta.config)

  vim.keymap.set("n", "<leader>;", "<cmd>Alpha<cr>", { desc = "Dashboard" })
  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

      local footer = {
        type = "text",
        val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms",
        opts = {
          hl = "SpecialComment",
          position = "center",
        },
      }

      table.insert(theta.config.layout, { type = "padding", val = 4 })
      table.insert(theta.config.layout, footer)
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end
