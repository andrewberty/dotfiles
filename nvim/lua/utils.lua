local M = {}

M.hl = function(name, opts) return vim.api.nvim_set_hl(0, name, opts) end

M.ignored_colors = {
	"default",
	"vim",
	"retrobox",
	"sorbet",
	"wildcharm",
	"zaibatsu",
	"desert",
	"evening",
	"industry",
	"koehler",
	"morning",
	"murphy",
	"pablo",
	"peachpuff",
	"ron",
	"shine",
	"slate",
	"torte",
	"zellner",
	"blue",
	"darkblue",
	"delek",
	"quiet",
	"elflord",
	"habamax",
	"lunaperche",
}

M.logos = {
	[[
	                                  __
	     ___     ___    ___   __  __ /\_\    ___ ___
	    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
	   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
	   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
	    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
    ]],
	[[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
 ]],
}
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

function M.hsl(h, s, l)
	h, s, l = h / 360, s / 100, l / 100
	local r, g, b

	if s == 0 then
		r, g, b = l, l, l -- achromatic
	else
		local function hue_to_rgb(p, q, t)
			if t < 0 then t = t + 1 end
			if t > 1 then t = t - 1 end
			if t < 1 / 6 then return p + (q - p) * 6 * t end
			if t < 1 / 2 then return q end
			if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
			return p
		end

		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q

		r = hue_to_rgb(p, q, h + 1 / 3)
		g = hue_to_rgb(p, q, h)
		b = hue_to_rgb(p, q, h - 1 / 3)
	end

	return string.format("#%02X%02X%02X", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end

return M
