-- ██╗   ██╗████████╗██╗██╗     ███████╗
-- ██║   ██║╚══██╔══╝██║██║     ██╔════╝
-- ██║   ██║   ██║   ██║██║     ███████╗
-- ██║   ██║   ██║   ██║██║     ╚════██║
-- ╚██████╔╝   ██║   ██║███████╗███████║
--  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝
--

local M = {}

M.nmap = function(lhs, rhs, opts)
  local options = { silent = true, noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set("n", lhs, rhs, options)
end

M.vmap = function(lhs, rhs, opts)
  local options = { silent = true, noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set("v", lhs, rhs, options)
end

M.nvmap = function(lhs, rhs, opts)
  local options = { silent = true, noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set({ "n", "v" }, lhs, rhs, options)
end

M.imap = function(lhs, rhs, opts)
  local options = { silent = true, noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set("i", lhs, rhs, options)
end

M.active_colorscheme = function()
  return vim.g.colors_name
end

M.drinks = {
  [[
            __
           )==(
           )==(
           |H |
           |H |
           |H |
          /====\
         / Dr S \
        /========\
       :HHHHHHHH H:
       |HHHHHHHH H|
       |HHHHHHHH H|
       |HHHHHHHH H|
\______|=/========\________/
 \     :/oO/      |\      /
  \    / oOOO  Le | \    /
   \__/| OOO Grape|  \__/
    )( |  O       |   )(
    )( |==========|   )(
    )( |HHHHHHHH H|   )(
    )( |HHHHHHHH H|   )(
   .)(.|HHHHHHHH H|  .)(.
  ~~~~~~~~~~~~~~~~  ~~~~~~
]],
  [[
  .   *   ..  . *  *
*  * @()Ooc()*   o  .
    (Q@*0CG*O()  ___
   |\_________/|/ _ \
   |  |  |  |  | / | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | \_| |
   |  |  |  |  |\___/
   |\_|__|__|_/|
    \_________/
]],
  [[
               __
              [__]
              |  |
              |  |
              |  |
              |  |
              |  |
 ,----.      /`-. \
(      )    /-._|  \
|`----'|   |        |
\      /   |`-...   |
 `.  ,'    |'` . |  |
   ||      |`,'- |  |
 ,-||-.    |`-...|  |
(  ''  )   |        |
 `----'     `-....-'
  ]],
}
return M
