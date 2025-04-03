local hsl = require("utils").hsl

local colors = {
	fg = hsl(0, 0, 100),
	fgAlt = hsl(0, 0, 33),

	bg0 = "NONE",
	bg1 = hsl(0, 0, 8),
	bg2 = hsl(0, 0, 16),
	grey = hsl(0, 0, 20),

	-- ui colors
	red = hsl(0, 100, 75),
	orange = hsl(27, 100, 83),
	primary = hsl(0, 0, 63),
	green = hsl(164, 100, 80),
	symbol = hsl(206, 11, 45),
}

local function set_terminal_colors()
	vim.g.terminal_color_0 = colors.bg0
	vim.g.terminal_color_1 = colors.red
	vim.g.terminal_color_2 = colors.green
	vim.g.terminal_color_3 = colors.orange
	vim.g.terminal_color_4 = colors.green
	vim.g.terminal_color_5 = colors.orange
	vim.g.terminal_color_6 = colors.primary
	vim.g.terminal_color_7 = colors.fg
	vim.g.terminal_color_8 = colors.grey
	vim.g.terminal_color_9 = colors.red
	vim.g.terminal_color_10 = colors.orange
	vim.g.terminal_color_11 = colors.orange
	vim.g.terminal_color_12 = colors.symbol
	vim.g.terminal_color_13 = colors.red
	vim.g.terminal_color_14 = colors.orange
	vim.g.terminal_color_15 = colors.fgAlt
	vim.g.terminal_color_background = colors.bg0
	vim.g.terminal_color_foreground = colors.fg
end

local function set_groups()
	local groups = {
		-- base
		Normal = { fg = colors.fg, bg = colors.bg0 },
		LineNr = { fg = colors.grey },
		ColorColumn = { bg = colors.primary },
		Conceal = {},
		Cursor = { fg = colors.bg0, bg = colors.fg },
		lCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },
		CursorLine = { bg = colors.bg2 },
		CursorColumn = { link = "CursorLine" },
		Directory = { fg = colors.green },
		DiffAdd = { bg = colors.bg0, fg = colors.green },
		DiffChange = { bg = colors.bg0, fg = colors.orange },
		DiffDelete = { bg = colors.bg0, fg = colors.red },
		DiffText = { bg = colors.bg0, fg = colors.symbol },
		EndOfBuffer = { fg = colors.orange },
		TermCursor = { link = "Cursor" },
		TermCursorNC = { link = "Cursor" },
		ErrorMsg = { fg = colors.red },
		VertSplit = { fg = colors.bg2, bg = colors.bg0 },
		Winseparator = { link = "VertSplit" },
		SignColumn = { link = "Normal" },
		Folded = { fg = colors.fg, bg = colors.bg1 },
		FoldColumn = { link = "SignColumn" },
		IncSearch = { bg = colors.orange, fg = colors.bg2 },
		Substitute = { link = "IncSearch" },
		CursorLineNr = { fg = colors.fg },
		MatchParen = { fg = colors.orange, bg = colors.bg0 },
		ModeMsg = { link = "Normal" },
		MsgArea = { link = "Normal" },
		-- MsgSeparator = {},
		MoreMsg = { fg = colors.green },
		NonText = { fg = colors.fgAlt },
		NormalFloat = { bg = colors.bg0 },
		FloatBorder = { fg = colors.bg2 },
		NormalNC = { link = "Normal" },
		Pmenu = { link = "NormalFloat" },
		PmenuSel = { bg = colors.bg2 },
		PmenuSbar = { bg = colors.green },
		PmenuThumb = { bg = colors.bg1 },
		Question = { fg = colors.green },
		QuickFixLine = { fg = colors.green },
		SpecialKey = { fg = colors.symbol },
		StatusLine = { fg = colors.fg, bg = colors.bg0 },
		StatusLineNC = { fg = colors.grey, bg = colors.bg2 },
		TabLine = { bg = colors.bg2, fg = colors.grey },
		TabLineFill = { link = "TabLine" },
		TabLineSel = { bg = colors.bg0, fg = colors.fg },
		Search = { link = "IncSearch" },
		SpellBad = { undercurl = true, sp = colors.primary },
		SpellCap = { undercurl = true, sp = colors.green },
		SpellLocal = { undercurl = true, sp = colors.orange },
		SpellRare = { undercurl = true, sp = colors.orange },
		Title = { fg = colors.green },
		Visual = { bg = colors.bg2 },
		VisualNOS = { link = "Visual" },
		WarningMsg = { fg = colors.orange },
		Whitespace = { fg = colors.symbol },
		WildMenu = { bg = colors.bg2 },
		Comment = { fg = colors.fgAlt },

		Constant = { fg = colors.fg },
		String = { fg = colors.green },
		Character = { fg = colors.green },
		Number = { fg = colors.fg, bold = true },
		Boolean = { fg = colors.green },
		Float = { link = "Number" },

		Identifier = { fg = colors.fg },
		Function = { fg = colors.orange },
		Method = { fg = colors.orange },
		Property = { fg = colors.green },
		Field = { link = "Property" },
		Parameter = { fg = colors.fg },
		Statement = { fg = colors.primary },
		Conditional = { fg = colors.primary },
		-- Repeat = {},
		Label = { fg = colors.green },
		Operator = { fg = colors.primary },
		Keyword = { link = "Statement" },
		Exception = { fg = colors.orange },

		PreProc = { link = "Keyword" },
		-- Include = {},
		Define = { fg = colors.orange },
		Macro = { link = "Define" },
		PreCondit = { fg = colors.primary },

		Type = { fg = colors.fg },
		Struct = { link = "Type" },
		Class = { link = "Type" },

		-- StorageClass = {},
		-- Structure = {},
		-- Typedef = {},

		Attribute = { fg = colors.primary },
		Punctuation = { fg = colors.symbol },
		Special = { fg = colors.symbol },

		SpecialChar = { fg = colors.orange },
		Tag = { fg = colors.orange },
		Delimiter = { fg = colors.symbol },
		-- SpecialComment = {},
		Debug = { fg = colors.orangeDark },

		Underlined = { underline = true },
		Bold = { bold = true },
		Italic = { italic = true },
		Ignore = { fg = colors.bg0 },
		Error = { link = "ErrorMsg" },
		Todo = { fg = colors.orange, bold = true },

		-- LspReferenceText = {},
		-- LspReferenceRead = {},
		-- LspReferenceWrite = {},
		-- LspCodeLens = {},
		-- LspCodeLensSeparator = {},
		-- LspSignatureActiveParameter = {},

		DiagnosticError = { link = "Error" },
		DiagnosticWarn = { link = "WarningMsg" },
		DiagnosticInfo = { fg = colors.green },
		DiagnosticHint = { fg = colors.symbol },
		DiagnosticErrorLn = { fg = colors.red, bg = colors.red },
		DiagnosticWarnLn = { fg = colors.orange, bg = colors.orange },
		DiagnosticInfoLn = { fg = colors.green, bg = colors.green },
		DiagnosticHintLn = { fg = colors.symbol, bg = colors.symbol },
		DiagnosticVirtualTextError = { link = "DiagnosticError" },
		DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
		DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
		DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
		DiagnosticUnderlineError = { undercurl = true, link = "DiagnosticError" },
		DiagnosticUnderlineWarn = { undercurl = true, link = "DiagnosticWarn" },
		DiagnosticUnderlineInfo = { undercurl = true, link = "DiagnosticInfo" },
		DiagnosticUnderlineHint = { undercurl = true, link = "DiagnosticHint" },
		-- DiagnosticFloatingError = {},
		-- DiagnosticFloatingWarn = {},
		-- DiagnosticFloatingInfo = {},
		-- DiagnosticFloatingHint = {},
		-- DiagnosticSignError = {},
		-- DiagnosticSignWarn = {},
		-- DiagnosticSignInfo = {},
		-- DiagnosticSignHint = {},

		-- Tree-Sitter groups are defined with an "@" symbol, which must be
		-- specially handled to be valid lua code, we do this via the special
		-- sym function. The following are all valid ways to call the sym function,
		-- for more details see https://www.lua.org/pil/5.html
		--
		-- sym("@text.literal")
		-- sym('@text.literal')
		-- sym"@text.literal"
		-- sym'@text.literal'
		--
		-- For more information see https://github.com/rktjmp/lush.nvim/issues/109

		["@text"] = { fg = colors.fg },
		["@texcolors.literal"] = { link = "Property" },
		-- ["@texcolors.reference"] = {},
		["@texcolors.strong"] = { link = "Bold" },
		["@texcolors.italic"] = { link = "Italic" },
		["@texcolors.title"] = { link = "Keyword" },
		["@texcolors.uri"] = { fg = colors.green, sp = colors.green, underline = true },
		["@texcolors.underline"] = { link = "Underlined" },
		["@symbol"] = { fg = colors.symbol },
		["@texcolors.todo"] = { link = "Todo" },
		["@comment"] = { link = "Comment" },
		["@punctuation"] = { link = "Punctuation" },
		["@punctuation.bracket"] = { fg = colors.primary },
		["@punctuation.delimiter"] = { link = "Delimiter" },
		["@punctuation.separator.keyvalue"] = { fg = colors.primary },

		["@texcolors.diff.add"] = { fg = colors.green },
		["@texcolors.diff.delete"] = { fg = colors.red },

		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Constant" },
		["@constancolors.builtin"] = { link = "Keyword" },
		-- ["@constancolors.macro"] = {},
		-- ["@define"] = {},
		-- ["@macro"] = {},
		["@string"] = { link = "String" },
		["@string.escape"] = { fg = colors.orange },
		["@string.special"] = { fg = colors.orange },
		["@string.special.url"] = { underline = true },
		-- ["@character"] = {},
		-- ["@character.special"] = {},
		["@number"] = { link = "Number" },
		["@boolean"] = { link = "Boolean" },
		-- ["@float"] = {},
		["@function"] = { link = "Function" },
		["@function.call"] = { link = "Function" },
		["@function.builtin"] = { link = "Function" },
		-- ["@function.macro"] = {},
		["@parameter"] = { link = "Parameter" },
		["@method"] = { link = "Function" },
		["@field"] = { link = "Property" },
		["@property"] = { fg = colors.orange },
		["@constructor"] = { fg = colors.primary },
		-- ["@conditional"] = {},
		-- ["@repeat"] = {},
		["@label"] = { link = "Label" },
		["@operator"] = { link = "Operator" },
		["@exception"] = { link = "Exception" },
		["@variable"] = { fg = colors.fg },
		["@variable.builtin"] = { fg = colors.fg },
		["@type"] = { fg = colors.orange },
		["@type.definition"] = { fg = colors.fg },
		["@type.builtin"] = { fg = colors.orange },
		["@type.qualifier"] = { fg = colors.orange },
		["@keyword"] = { link = "Keyword" },
		-- ["@storageclass"] = {},
		-- ["@structure"] = {},
		["@namespace"] = { link = "Type" },
		["@annotation"] = { link = "Label" },
		-- ["@include"] = {},
		-- ["@preproc"] = {},
		["@debug"] = { fg = colors.orangeDark },
		["@tag"] = { link = "Tag" },
		["@_tag"] = { link = "Tag" },
		["@tag.builtin"] = { link = "Tag" },
		["@tag.delimiter"] = { fg = colors.primary },
		["@tag.attribute"] = { fg = colors.primary },
		["@attribute"] = { link = "Attribute" },
		["@error"] = { link = "Error" },
		["@warning"] = { link = "WarningMsg" },
		["@info"] = { fg = colors.green },
		["@markup.link.label"] = { underline = false },
		["@none"] = { fg = colors.fg },

		-- Specific languages
		-- overrides
		["@label.json"] = { fg = colors.property }, -- For json
		["@label.help"] = { link = "@texcolors.uri" }, -- For help files
		["@texcolors.uri.html"] = { underline = true }, -- For html

		-- semantic highlighting
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.type"] = { link = "@type" },
		["@lsp.type.class"] = { link = "@type" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.interface"] = { link = "@type" },
		["@lsp.type.struct"] = { link = "@type" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@text" },
		["@lsp.type.enumMember"] = { link = "@constant" },
		["@lsp.type.function"] = { link = "@function" },
		["@lsp.type.method"] = { link = "@method" },
		["@lsp.type.macro"] = { link = "@label" },
		["@lsp.type.decorator"] = { link = "@label" },
		["@lsp.typemod.function.declaration"] = { link = "@function" },
		["@lsp.typemod.function.readonly"] = { link = "@function" },
	}

	for group, parameters in pairs(groups) do
		vim.api.nvim_set_hl(0, group, parameters)
	end
end

local function setup()
	vim.api.nvim_command("hi clear")
	if vim.fn.exists("syntax_on") then vim.api.nvim_command("syntax reset") end

	vim.g.VM_theme_set_by_colorscheme = true -- Required for Visual Multi
	vim.o.termguicolors = true
	vim.g.colors_name = "vesper"

	set_terminal_colors()
	set_groups()
end

setup()
