return {
	{
		"echasnovski/mini.icons",
		version = false,
		config = function()
			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			vim.keymap.set({ "n", "x" }, "s", "<Nop>")
			require("mini.surround").setup({ mappings = { add = "s" } })

			vim.keymap.set(
				{ "n", "x" },
				"<leader>cn",
				"saq{saq(F(icnjkf)i,classNamejkF(",
				{ remap = true, silent = true, desc = "Surround around quotes with cn()" }
			)
		end,
	},
	{ "echasnovski/mini.ai", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },
	{
		"echasnovski/mini.hipatterns",
		version = "*",
		config = function()
			local hipatterns = require("mini.hipatterns")

			local function get_highlight(cb)
				return function(_, match)
					local style = "bg"
					return hipatterns.compute_hex_color_group(cb(match), style)
				end
			end

			local function get_hsl(match)
				local hsl = require("utils").hsl

				local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
				local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
				local hex = hsl(h, s, l)
				return hex
			end

			local function get_hex_short(match)
				local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
				local hex = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
				return hex
			end

			local function rgb_color(match)
				local red, green, blue = match:match("rgb%((%d+), ?(%d+), ?(%d+)%)")
				local hex = string.format("#%02x%02x%02x", red, green, blue)
				return hex
			end

			local function rgba_color(match)
				local red, green, blue, alpha = match:match("rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)")
				alpha = tonumber(alpha)
				if alpha == nil or alpha < 0 or alpha > 1 then return false end
				local hex = string.format("#%02x%02x%02x", red * alpha, green * alpha, blue * alpha)
				return hex
			end

			hipatterns.setup({
				highlighters = {
					hex_color = hipatterns.gen_highlighter.hex_color(),

					hex_color_short = {
						pattern = "#%x%x%x%f[%X]",
						group = get_highlight(get_hex_short),
					},

					rgb_color = {
						pattern = "rgb%(%d+, ?%d+, ?%d+%)",
						group = get_highlight(rgb_color),
					},

					rgba_color = {
						pattern = "rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)",
						group = get_highlight(rgba_color),
					},

					hsl_color = {
						pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
						group = get_highlight(get_hsl),
					},
				},
			})
		end,
	},
}
