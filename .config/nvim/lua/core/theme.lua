local M = {}
M.apply = function()
local colors = {
        fg         = "#e0e0e0",
        fg_dark    = "#111117",
        selection  = "#272740",
        cursorline = "#171720",
        blue       = "#207d8a",
        green      = "#50ea7b",
        cyan       = "#6bc7dd",
        red        = "#fe1858",
        magenta    = "#ee79c6",
        yellow     = "#e1ea8c",
        comment    = "#424242",
}

local hl = function(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
end

-- UI
hl("FloatBorder", { fg = colors.cyan, bg = "NONE" })
hl("WinSeparator", { fg = colors.comment, bg = "NONE" })
hl("NormalFloat", { bg = "#171720" })
hl("CursorLineNr", { fg = cyan, bg = "NONE", bold = true })
hl("LineNrAbove",   { fg = "#555577", bg = "NONE" })
hl("LineNrBelow",   { fg = "#555577", bg = "NONE" })
hl("CursorLineSign", { bg = "NONE" })
hl("CursorLineFold", { bg = "NONE" })
hl("SignColumn",                { bg = "NONE" })
hl("LineNr",                    { bg = "NONE" })

-- Blink.cmp
hl("BlinkCmpMenu", { bg = "#222233" })
hl("BlinkCmpMenuBorder", { fg = colors.comment, bg = "#222233" })
hl("BlinkCmpDoc", { bg = "#222233" })
hl("BlinkCmpDocBorder", { fg = colors.comment, bg = "#222233" })
hl("BlinkCmpSignatureHelp", { bg = "#222233" })
hl("BlinkCmpSignatureHelpBorder", { fg = colors.comment, bg = "#222233" })
hl("BlinkCmpMenuSelection", { bg = colors.selection, bold = true })

-- Things
hl("Search", { fg = colors.bg, bg = colors.yellow })
hl("MatchParen", { fg = colors.cyan, bg = colors.yellow, bold = true})

-- Git
hl("GitSignsAdd", { fg = colors.green, bg = "NONE" })
hl("GitSignsChange", { fg = colors.blue, bg = "NONE" })
hl("GitSignsDelete", { fg = colors.red, bg = "NONE" })

-- Unused Code
hl("DiagnosticUnnecessary", { fg = colors.comment, italic = true })
hl("@lsp.mod.unused", { link = "DiagnosticUnnecessary" })
hl("@lsp.type.unresolvedReference", { fg = colors.red, undercurl = true })

-- Telescope
hl("TelescopeBorder", { fg = colors.cyan })
hl("TelescopeMatching", { fg = colors.yellow, bold = true })
hl("TelescopeSelection", { bg = colors.selection })

-- Nvim Tree
hl("NvimTreeFolderName", { fg = colors.blue, bold = true })
hl("NvimTreeOpenedFolderName", { fg = colors.blue, bold = true, italic = true })
hl("NvimTreeGitDirty", { fg = colors.blue })
hl("NvimTreeGitNew", { fg = colors.green })

-- WhichKey
hl("WhichKey", { fg = colors.cyan })
hl("WhichKeyGroup", { fg = colors.magenta })
hl("WhichKeyDesc", { fg = colors.fg })

-- RenderMarkdown
hl("RenderMarkdownH1", { fg = colors.red, bold = true })
hl("RenderMarkdownH2", { fg = colors.blue, bold = true })
hl("RenderMarkdownH3", { fg = colors.cyan, bold = true })
hl("RenderMarkdownH4", { fg = colors.green, bold = true })
hl("RenderMarkdownH5", { fg = colors.yellow, bold = true })
hl("RenderMarkdownH6", { fg = colors.magenta, bold = true })

hl("RenderMarkdownH1Bg", { fg = colors.red,      bg = "#21050f", bold = true })
hl("RenderMarkdownH2Bg", { fg = colors.blue,     bg = "#10202d", bold = true })
hl("RenderMarkdownH3Bg", { fg = colors.cyan,     bg = "#0b1a20", bold = true })
hl("RenderMarkdownH4Bg", { fg = colors.green,    bg = "#05201b", bold = true })
hl("RenderMarkdownH5Bg", { fg = colors.yellow,   bg = "#1e220c", bold = true })
hl("RenderMarkdownH6Bg", { fg = colors.magenta,  bg = "#2e0916", bold = true })

hl("RenderMarkdownCode", { bg = "#171720" })
hl("RenderMarkdownUnchecked", {fg = colors.blue})
hl("RenderMarkdownChecked", {fg = colors.cyan})
hl("RenderMarkdownCurrent", {fg = colors.magenta})

-- LSP
hl("LspReferenceText",  { bg = colors.selection, underline = true })
hl("LspReferenceRead",  { bg = colors.selection, underline = true })
hl("LspReferenceWrite", { bg = colors.selection, underline = true, fg = colors.yellow })

hl("DiagnosticError", { fg = colors.red,    bg = "NONE" })
hl("DiagnosticWarn",  { fg = colors.yellow, bg = "NONE" })
hl("DiagnosticInfo",  { fg = colors.cyan,   bg = "NONE" })
hl("DiagnosticHint",  { fg = colors.green,  bg = "NONE" })

hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = colors.yellow })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = colors.cyan })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = colors.green })

hl("DiagnosticSignError", { fg = colors.red,    bg = "NONE" })
hl("DiagnosticSignWarn",  { fg = colors.yellow, bg = "NONE" })
hl("DiagnosticSignInfo",  { fg = colors.cyan,   bg = "NONE" })
hl("DiagnosticSignHint",  { fg = colors.green,  bg = "NONE" })

-- Mini.statusline
hl("MiniStatuslineModeNormal",  { fg = colors.fg,      bg = "NONE", bold = true})
hl("MiniStatuslineModeInsert",  { fg = colors.green,   bg = "NONE", bold = true})
hl("MiniStatuslineModeVisual",  { fg = colors.cyan,    bg = "NONE", bold = true})
hl("MiniStatuslineModeReplace", { fg = colors.red,     bg = "NONE", bold = true})
hl("MiniStatuslineModeCommand", { fg = colors.yellow,  bg = "NONE", bold = true})
hl("MiniStatuslineModeOther",   { fg = colors.yellow,  bg = "NONE", bold = true})

hl("MiniStatuslineFilename",    { fg = colors.fg_dark, bg = colors.cyan})
hl("MiniStatuslineInactive",    { fg = colors.fg, bg = "NONE", italic = true })
hl("StatusLine",                { bg = "#171720",         reverse = false })
hl("CursorLine",                { bg = colors.cursorline })
hl("CursorLineNr",              { fg = colors.cyan })

hl("Normal", { fg = colors.fg, bg = "NONE" })
hl("NoneText", { fg = colors.comment, bg = "NONE" })

hl("Visual", { bg = colors.selection })
hl("VisualNOS", { bg = colors.selection })

-- Syntax
hl("Comment", { fg = colors.comment, italic = true })

hl("Constant", { fg = colors.blue })
hl("String", { fg = colors.green })
hl("Character", { fg = colors.green })
hl("Number", { fg = colors.blue })
hl("Boolean", { fg = colors.blue })
hl("Float", { fg = colors.blue })

hl("Identifier", { fg = colors.fg })         -- variable
hl("Function", { fg = colors.yellow })       -- functions

hl("Statement", { fg = colors.magenta })     -- if, else, for, return, try
hl("Conditional", { fg = colors.magenta })
hl("Repeat", { fg = colors.magenta })
hl("Operator", { fg = colors.cyan })         -- <<, >>, +, -, etc.
hl("Keyword", { fg = colors.magenta })       -- class, namespace, public
hl("StorageClass", { fg = colors.magenta }) -- 'static', 'const', 'class' (bazı dillerde)
hl("Structure", { fg = colors.magenta })    -- 'struct', 'class', 'enum'

hl("PreProc", { fg = colors.blue })          -- #include, #define
hl("Include", { fg = colors.blue })
hl("Define", { fg = colors.blue })
hl("Macro", { fg = colors.blue })

hl("Type", { fg = colors.cyan })             -- int, float, bool, class
hl("StorageClass", { fg = colors.magenta })  -- static, const

hl("Special", { fg = colors.cyan })          -- escapes etc.
hl("Delimiter", { fg = colors.fg })          -- ; { } ( ) :

hl("Error", { fg = colors.red, bg = "NONE", italic = true, underline = true, reverse = false })
-- TreeSitter
hl("@variable", { fg = colors.fg })
hl("@variable.builtin", { fg = colors.cyan })
hl("@variable.parameter", { fg = colors.blue })
hl("@property", { fg = colors.fg })
hl("@constructor", { fg = colors.cyan })

-- JSON specific
hl("jsonKeyword", { fg = colors.magenta })
hl("@label.json", { fg = colors.magenta })
hl("@string.special.key.json", { fg = colors.magenta })
hl("@namespace", { fg = colors.magenta })
hl("@module", { fg = colors.green })
hl("@type.builtin", { fg = colors.cyan })
hl("@punctuation.bracket", { fg = colors.fg })
hl("@punctuation.delimiter", { fg = colors.fg })
hl("@constant.macro", { fg = colors.blue })
hl("@keyword", { fg = colors.magenta })
hl("@keyword.function", { fg = colors.magenta }) -- 'def', 'fn', 'function'
hl("@keyword.type", { fg = colors.magenta })     -- 'class', 'struct', 'enum', 'type'
hl("@keyword.operator", { fg = colors.cyan })    -- 'and', 'or', 'in'
hl("@storageclass", { fg = colors.magenta })
hl("@type.qualifier", { fg = colors.magenta })
end
return M
