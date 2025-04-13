local function kebabToPascalCase(str)
	local result = ""
	for part in string.gmatch(str, "[^-]+") do
		result = result .. part:sub(1, 1):upper() .. part:sub(2)
	end

	return result
end

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	lazy = true,
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "javascriptreact", "typescriptreact" } })

		local ls = require("luasnip")
		local s = ls.snippet
		local sn = ls.snippet_node
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node
		local d = ls.dynamic_node

		local react = {
			s({
				trig = "rfc",
				desc = "React Component",
			}, {
				t("export default function "),
				d(
					1,
					function(_, snip)
						return sn(nil, {
							i(1, kebabToPascalCase(snip.env.TM_FILENAME_BASE)),
						})
					end
				),
				t("("),
				i(2),
				t(") {"),
				t({ "", "  return <div>" }),
				f(function(_, snip) return snip.env.TM_FILENAME_BASE end),
				t("</div>"),
				t({ "", "}" }),
			}),
			s({ trig = "ref", desc = "useRef" }, { t("const "), i(1, "ref"), t(" = useRef("), i(2), t(")") }),
			s(
				{ trig = "state", desc = "useState" },
				{ t("const ["), i(1), t(", set"), i(2), t("] = useState("), i(3), t(")") }
			),
			s({ trig = "eff", desc = "useEffect" }, { t("useEffect(() => {"), i(1), t("},["), i(2), t("])") }),
		}

		local js_ts = {
			s({ trig = "cl", desc = "console.log" }, { t("console.log("), i(1), t(")") }),
			s({ trig = "prom", desc = "Promise" }, { t("return new Promise((resolve, reject) => { "), i(1), t(" })") }),
		}

		ls.add_snippets("javascript", vim.tbl_extend("force", js_ts, react))
		ls.add_snippets("typescript", vim.tbl_extend("force", js_ts, react))

		-- react snippets
		ls.filetype_extend("javascriptreact", { "javascript" })
		ls.filetype_extend("typescriptreact", { "javascript" })
	end,
}
