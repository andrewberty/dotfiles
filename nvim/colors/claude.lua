local hsl = require("utils").hsl

local colors = {
	fg = hsl(0, 0, 82),
	fgAlt = hsl(0, 0, 33),

	bg0 = "NONE",
	bg1 = hsl(0, 0, 7),
	bg2 = hsl(0, 0, 14),
	grey = hsl(0, 0, 20),

	-- brand orange is the only accent
	orange = hsl(27, 70, 56),
	orangeLight = hsl(27, 70, 66),

	-- everything else is grey
	primary = hsl(0, 0, 56),
	dim = hsl(0, 0, 40),
	symbol = hsl(0, 0, 35),
}

local function set_terminal_colors()
	vim.g.terminal_color_0 = colors.bg1
	vim.g.terminal_color_1 = colors.orange
	vim.g.terminal_color_2 = colors.dim
	vim.g.terminal_color_3 = colors.orange
	vim.g.terminal_color_4 = colors.primary
	vim.g.terminal_color_5 = colors.dim
	vim.g.terminal_color_6 = colors.primary
	vim.g.terminal_color_7 = colors.fg
	vim.g.terminal_color_8 = colors.grey
	vim.g.terminal_color_9 = colors.orangeLight
	vim.g.terminal_color_10 = colors.dim
	vim.g.terminal_color_11 = colors.orangeLight
	vim.g.terminal_color_12 = colors.primary
	vim.g.terminal_color_13 = colors.dim
	vim.g.terminal_color_14 = colors.primary
	vim.g.terminal_color_15 = colors.fg
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
		Directory = { fg = colors.primary },
		DiffAdd = { bg = colors.bg0, fg = colors.dim },
		DiffChange = { bg = colors.bg0, fg = colors.orange },
		DiffDelete = { bg = colors.bg0, fg = colors.orange },
		DiffText = { bg = colors.bg0, fg = colors.symbol },
		EndOfBuffer = { fg = colors.grey },
		TermCursor = { link = "Cursor" },
		TermCursorNC = { link = "Cursor" },
		ErrorMsg = { fg = colors.orange },
		VertSplit = { fg = colors.bg2, bg = colors.bg0 },
		Winbar = { fg = colors.bg2, bg = colors.bg0 },
		WinbarNC = { fg = colors.bg2, bg = colors.bg0 },
		Winseparator = { link = "VertSplit" },
		SignColumn = { link = "Normal" },
		Folded = { fg = colors.fg, bg = colors.bg1 },
		FoldColumn = { link = "SignColumn" },
		IncSearch = { bg = colors.orange, fg = colors.bg1 },
		Substitute = { link = "IncSearch" },
		CursorLineNr = { fg = colors.fg },
		MatchParen = { fg = colors.orange, bg = colors.bg0 },
		ModeMsg = { link = "Normal" },
		MsgArea = { link = "Normal" },
		MoreMsg = { fg = colors.primary },
		NonText = { fg = colors.fgAlt },
		NormalFloat = { bg = colors.bg0 },
		NvimTreeIndentMarker = { fg = colors.fgAlt },
		FloatBorder = { fg = colors.bg2 },
		NormalNC = { link = "Normal" },
		Pmenu = { link = "NormalFloat" },
		PmenuSel = { bg = colors.bg2 },
		PmenuSbar = { bg = colors.grey },
		PmenuThumb = { bg = colors.bg1 },
		Question = { fg = colors.primary },
		QuickFixLine = { fg = colors.orange },
		SpecialKey = { fg = colors.symbol },
		StatusLine = { fg = colors.fg, bg = colors.bg0 },
		StatusLineNC = { fg = colors.grey, bg = colors.bg0 },
		TabLine = { bg = colors.bg2, fg = colors.grey },
		TabLineFill = { link = "TabLine" },
		TabLineSel = { bg = colors.bg0, fg = colors.fg },
		Search = { link = "IncSearch" },
		SpellBad = { undercurl = true, sp = colors.orange },
		SpellCap = { undercurl = true, sp = colors.primary },
		SpellLocal = { undercurl = true, sp = colors.orange },
		SpellRare = { undercurl = true, sp = colors.dim },
		Title = { fg = colors.orange },
		Visual = { bg = colors.bg2 },
		VisualNOS = { link = "Visual" },
		WarningMsg = { fg = colors.orange },
		Whitespace = { fg = colors.symbol },
		WildMenu = { bg = colors.bg2 },
		Comment = { fg = colors.fgAlt },

		Constant = { fg = colors.fg },
		String = { fg = colors.primary },
		Character = { fg = colors.primary },
		Number = { fg = colors.fg, bold = true },
		Boolean = { fg = colors.primary },
		Float = { link = "Number" },

		Identifier = { fg = colors.fg },
		Function = { fg = colors.orange },
		Method = { fg = colors.orange },
		Property = { fg = colors.fg },
		Field = { link = "Property" },
		Parameter = { fg = colors.fg },
		Statement = { fg = colors.primary },
		Conditional = { fg = colors.primary },
		Label = { fg = colors.primary },
		Operator = { fg = colors.primary },
		Keyword = { link = "Statement" },
		Exception = { fg = colors.orange },

		PreProc = { link = "Keyword" },
		Define = { fg = colors.orange },
		Macro = { link = "Define" },
		PreCondit = { fg = colors.primary },

		Type = { fg = colors.fg },
		Struct = { link = "Type" },
		Class = { link = "Type" },

		Attribute = { fg = colors.primary },
		Punctuation = { fg = colors.symbol },
		Special = { fg = colors.symbol },

		SpecialChar = { fg = colors.orange },
		Tag = { fg = colors.orange },
		Delimiter = { fg = colors.symbol },
		Debug = { fg = colors.orange },

		Underlined = { underline = true },
		Bold = { bold = true },
		Italic = { italic = true },
		Ignore = { fg = colors.bg0 },
		Error = { link = "ErrorMsg" },
		Todo = { fg = colors.orange, bold = true },

		DiagnosticError = { link = "Error" },
		DiagnosticWarn = { link = "WarningMsg" },
		DiagnosticInfo = { fg = colors.primary },
		DiagnosticHint = { fg = colors.symbol },
		DiagnosticErrorLn = { fg = colors.orange, bg = colors.orange },
		DiagnosticWarnLn = { fg = colors.orange, bg = colors.orange },
		DiagnosticInfoLn = { fg = colors.primary, bg = colors.primary },
		DiagnosticHintLn = { fg = colors.symbol, bg = colors.symbol },
		DiagnosticVirtualTextError = { link = "DiagnosticError" },
		DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
		DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
		DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
		DiagnosticUnderlineError = { undercurl = true, sp = colors.orange },
		DiagnosticUnderlineWarn = { undercurl = true, sp = colors.orange },
		DiagnosticUnderlineInfo = { undercurl = true, sp = colors.primary },
		DiagnosticUnderlineHint = { undercurl = true, sp = colors.symbol },

		-- treesitter
		["@text"] = { fg = colors.fg },
		["@texcolors.literal"] = { link = "Property" },
		["@texcolors.strong"] = { link = "Bold" },
		["@texcolors.italic"] = { link = "Italic" },
		["@texcolors.title"] = { link = "Keyword" },
		["@texcolors.uri"] = { fg = colors.primary, sp = colors.primary, underline = true },
		["@texcolors.underline"] = { link = "Underlined" },
		["@symbol"] = { fg = colors.symbol },
		["@texcolors.todo"] = { link = "Todo" },
		["@comment"] = { link = "Comment" },
		["@punctuation"] = { link = "Punctuation" },
		["@punctuation.bracket"] = { fg = colors.primary },
		["@punctuation.delimiter"] = { link = "Delimiter" },
		["@punctuation.separator.keyvalue"] = { fg = colors.primary },

		["@texcolors.diff.add"] = { fg = colors.dim },
		["@texcolors.diff.delete"] = { fg = colors.orange },

		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Constant" },
		["@constancolors.builtin"] = { link = "Keyword" },
		["@string"] = { link = "String" },
		["@string.escape"] = { fg = colors.orange },
		["@string.special"] = { fg = colors.orange },
		["@string.special.url"] = { underline = true },
		["@number"] = { link = "Number" },
		["@boolean"] = { link = "Boolean" },
		["@function"] = { link = "Function" },
		["@function.call"] = { link = "Function" },
		["@function.builtin"] = { link = "Function" },
		["@parameter"] = { link = "Parameter" },
		["@method"] = { link = "Function" },
		["@field"] = { link = "Property" },
		["@property"] = { fg = colors.fg },
		["@constructor"] = { fg = colors.primary },
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
		["@namespace"] = { link = "Type" },
		["@annotation"] = { link = "Label" },
		["@debug"] = { fg = colors.orange },
		["@tag"] = { link = "Tag" },
		["@_tag"] = { link = "Tag" },
		["@tag.builtin"] = { link = "Tag" },
		["@tag.delimiter"] = { fg = colors.primary },
		["@tag.attribute"] = { fg = colors.primary },
		["@attribute"] = { link = "Attribute" },
		["@error"] = { link = "Error" },
		["@warning"] = { link = "WarningMsg" },
		["@info"] = { fg = colors.primary },
		["@markup.link.label"] = { underline = false },
		["@none"] = { fg = colors.fg },

		-- language overrides
		["@label.json"] = { fg = colors.fg },
		["@label.help"] = { link = "@texcolors.uri" },
		["@texcolors.uri.html"] = { underline = true },

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

	vim.g.VM_theme_set_by_colorscheme = true
	vim.o.termguicolors = true
	vim.g.colors_name = "claude"

	set_terminal_colors()
	set_groups()
end

setup()
