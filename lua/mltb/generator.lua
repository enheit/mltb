-- Theme generator - converts color palette to full Neovim theme

local presets = require('mltb.presets')
local color_theory = require('mltb.color_theory')

local M = {}

-- Generate a complete theme from a color palette
-- @param palette table: color palette {bg, fg, red, orange, yellow, green, cyan, blue, purple}
-- @param theme_type string: "dark" or "light"
-- @return table: complete theme with all highlight groups
function M.generate_theme(palette, theme_type)
  local theme = {
    name = "",  -- Will be set when writing
    type = theme_type,
    palette = palette,
    highlights = {},
  }

  local bg = palette.bg
  local fg = palette.fg

  -- Derive additional UI colors
  local bg_lighter, bg_darker, fg_muted

  if theme_type == "dark" then
    bg_lighter = color_theory.adjust_lightness(bg, 5)
    bg_darker = color_theory.adjust_lightness(bg, -3)
    fg_muted = color_theory.adjust_lightness(fg, -30)
  else
    bg_lighter = color_theory.adjust_lightness(bg, 3)
    bg_darker = color_theory.adjust_lightness(bg, -5)
    fg_muted = color_theory.adjust_lightness(fg, 30)
  end

  -- Core UI highlights
  theme.highlights.Normal = {fg = fg, bg = bg}
  theme.highlights.NormalFloat = {fg = fg, bg = bg_lighter}
  theme.highlights.FloatBorder = {fg = palette.blue, bg = bg}

  -- Cursor
  theme.highlights.Cursor = {fg = bg, bg = fg}
  theme.highlights.CursorLine = {bg = bg_lighter}
  theme.highlights.CursorLineNr = {fg = palette.yellow, bold = true}
  theme.highlights.CursorColumn = {bg = bg_lighter}

  -- Line numbers
  theme.highlights.LineNr = {fg = fg_muted}
  theme.highlights.SignColumn = {fg = fg_muted, bg = bg}

  -- Visual selection
  theme.highlights.Visual = {bg = bg_lighter}
  theme.highlights.VisualNOS = {bg = bg_lighter}

  -- Search
  theme.highlights.Search = {fg = bg, bg = palette.yellow}
  theme.highlights.IncSearch = {fg = bg, bg = palette.orange}

  -- Status line
  theme.highlights.StatusLine = {fg = fg, bg = bg_darker}
  theme.highlights.StatusLineNC = {fg = fg_muted, bg = bg_darker}
  theme.highlights.WinBar = {fg = fg, bg = bg}
  theme.highlights.WinBarNC = {fg = fg_muted, bg = bg}

  -- Tab line
  theme.highlights.TabLine = {fg = fg_muted, bg = bg_darker}
  theme.highlights.TabLineFill = {bg = bg_darker}
  theme.highlights.TabLineSel = {fg = fg, bg = bg, bold = true}

  -- Messages
  theme.highlights.MsgArea = {fg = fg, bg = bg}
  theme.highlights.MsgSeparator = {fg = palette.blue, bg = bg}
  theme.highlights.MoreMsg = {fg = palette.green}
  theme.highlights.Question = {fg = palette.blue}
  theme.highlights.WarningMsg = {fg = palette.orange}
  theme.highlights.ErrorMsg = {fg = palette.red, bold = true}

  -- Popups/menus
  theme.highlights.Pmenu = {fg = fg, bg = bg_lighter}
  theme.highlights.PmenuSel = {fg = bg, bg = palette.blue, bold = true}
  theme.highlights.PmenuSbar = {bg = bg_lighter}
  theme.highlights.PmenuThumb = {bg = fg_muted}

  -- Diffs
  theme.highlights.DiffAdd = {fg = palette.green, bg = bg}
  theme.highlights.DiffChange = {fg = palette.yellow, bg = bg}
  theme.highlights.DiffDelete = {fg = palette.red, bg = bg}
  theme.highlights.DiffText = {fg = palette.cyan, bg = bg}

  -- Folds
  theme.highlights.Folded = {fg = fg_muted, bg = bg_lighter}
  theme.highlights.FoldColumn = {fg = fg_muted, bg = bg}

  -- Spelling
  theme.highlights.SpellBad = {fg = palette.red, underline = true, sp = palette.red}
  theme.highlights.SpellCap = {fg = palette.yellow, underline = true, sp = palette.yellow}
  theme.highlights.SpellLocal = {fg = palette.cyan, underline = true, sp = palette.cyan}
  theme.highlights.SpellRare = {fg = palette.purple, underline = true, sp = palette.purple}

  -- Syntax highlighting
  theme.highlights.Comment = {fg = fg_muted, italic = true}
  theme.highlights.Constant = {fg = palette.orange}
  theme.highlights.String = {fg = palette.green}
  theme.highlights.Character = {fg = palette.green}
  theme.highlights.Number = {fg = palette.orange}
  theme.highlights.Boolean = {fg = palette.orange}
  theme.highlights.Float = {fg = palette.orange}

  theme.highlights.Identifier = {fg = palette.red}
  theme.highlights.Function = {fg = palette.blue, bold = true}

  theme.highlights.Statement = {fg = palette.purple}
  theme.highlights.Conditional = {fg = palette.purple}
  theme.highlights.Repeat = {fg = palette.purple}
  theme.highlights.Label = {fg = palette.purple}
  theme.highlights.Operator = {fg = palette.cyan}
  theme.highlights.Keyword = {fg = palette.purple}
  theme.highlights.Exception = {fg = palette.red}

  theme.highlights.PreProc = {fg = palette.purple}
  theme.highlights.Include = {fg = palette.purple}
  theme.highlights.Define = {fg = palette.purple}
  theme.highlights.Macro = {fg = palette.cyan}
  theme.highlights.PreCondit = {fg = palette.purple}

  theme.highlights.Type = {fg = palette.yellow}
  theme.highlights.StorageClass = {fg = palette.yellow}
  theme.highlights.Structure = {fg = palette.yellow}
  theme.highlights.Typedef = {fg = palette.yellow}

  theme.highlights.Special = {fg = palette.cyan}
  theme.highlights.SpecialChar = {fg = palette.cyan}
  theme.highlights.Tag = {fg = palette.blue}
  theme.highlights.Delimiter = {fg = fg}
  theme.highlights.SpecialComment = {fg = fg_muted, italic = true}
  theme.highlights.Debug = {fg = palette.red}

  theme.highlights.Underlined = {fg = palette.blue, underline = true}
  theme.highlights.Ignore = {fg = fg_muted}
  theme.highlights.Error = {fg = palette.red, bold = true}
  theme.highlights.Todo = {fg = bg, bg = palette.yellow, bold = true}

  -- TreeSitter highlights
  theme.highlights["@variable"] = {fg = fg}
  theme.highlights["@variable.builtin"] = {fg = palette.red}
  theme.highlights["@variable.parameter"] = {fg = palette.orange}
  theme.highlights["@variable.member"] = {fg = palette.cyan}

  theme.highlights["@constant"] = {fg = palette.orange}
  theme.highlights["@constant.builtin"] = {fg = palette.orange}
  theme.highlights["@constant.macro"] = {fg = palette.cyan}

  theme.highlights["@string"] = {fg = palette.green}
  theme.highlights["@string.escape"] = {fg = palette.cyan}
  theme.highlights["@string.special"] = {fg = palette.cyan}
  theme.highlights["@character"] = {fg = palette.green}
  theme.highlights["@number"] = {fg = palette.orange}
  theme.highlights["@boolean"] = {fg = palette.orange}
  theme.highlights["@float"] = {fg = palette.orange}

  theme.highlights["@function"] = {fg = palette.blue, bold = true}
  theme.highlights["@function.builtin"] = {fg = palette.blue}
  theme.highlights["@function.macro"] = {fg = palette.cyan}
  theme.highlights["@function.call"] = {fg = palette.blue}
  theme.highlights["@method"] = {fg = palette.blue}
  theme.highlights["@method.call"] = {fg = palette.blue}
  theme.highlights["@constructor"] = {fg = palette.yellow}

  theme.highlights["@keyword"] = {fg = palette.purple}
  theme.highlights["@keyword.function"] = {fg = palette.purple}
  theme.highlights["@keyword.operator"] = {fg = palette.purple}
  theme.highlights["@keyword.return"] = {fg = palette.purple}

  theme.highlights["@conditional"] = {fg = palette.purple}
  theme.highlights["@repeat"] = {fg = palette.purple}
  theme.highlights["@label"] = {fg = palette.purple}
  theme.highlights["@operator"] = {fg = palette.cyan}
  theme.highlights["@exception"] = {fg = palette.red}

  theme.highlights["@type"] = {fg = palette.yellow}
  theme.highlights["@type.builtin"] = {fg = palette.yellow}
  theme.highlights["@type.definition"] = {fg = palette.yellow}

  theme.highlights["@property"] = {fg = palette.cyan}
  theme.highlights["@field"] = {fg = palette.cyan}
  theme.highlights["@parameter"] = {fg = palette.orange}

  theme.highlights["@comment"] = {fg = fg_muted, italic = true}
  theme.highlights["@punctuation.delimiter"] = {fg = fg}
  theme.highlights["@punctuation.bracket"] = {fg = fg}
  theme.highlights["@punctuation.special"] = {fg = palette.cyan}

  theme.highlights["@tag"] = {fg = palette.blue}
  theme.highlights["@tag.attribute"] = {fg = palette.cyan}
  theme.highlights["@tag.delimiter"] = {fg = fg}

  -- LSP semantic tokens
  theme.highlights["@lsp.type.class"] = {fg = palette.yellow}
  theme.highlights["@lsp.type.decorator"] = {fg = palette.cyan}
  theme.highlights["@lsp.type.enum"] = {fg = palette.yellow}
  theme.highlights["@lsp.type.enumMember"] = {fg = palette.orange}
  theme.highlights["@lsp.type.function"] = {fg = palette.blue}
  theme.highlights["@lsp.type.interface"] = {fg = palette.yellow}
  theme.highlights["@lsp.type.macro"] = {fg = palette.cyan}
  theme.highlights["@lsp.type.method"] = {fg = palette.blue}
  theme.highlights["@lsp.type.namespace"] = {fg = palette.yellow}
  theme.highlights["@lsp.type.parameter"] = {fg = palette.orange}
  theme.highlights["@lsp.type.property"] = {fg = palette.cyan}
  theme.highlights["@lsp.type.struct"] = {fg = palette.yellow}
  theme.highlights["@lsp.type.type"] = {fg = palette.yellow}
  theme.highlights["@lsp.type.typeParameter"] = {fg = palette.yellow}
  theme.highlights["@lsp.type.variable"] = {fg = fg}

  -- Diagnostics
  theme.highlights.DiagnosticError = {fg = palette.red}
  theme.highlights.DiagnosticWarn = {fg = palette.yellow}
  theme.highlights.DiagnosticInfo = {fg = palette.blue}
  theme.highlights.DiagnosticHint = {fg = palette.cyan}

  theme.highlights.DiagnosticUnderlineError = {undercurl = true, sp = palette.red}
  theme.highlights.DiagnosticUnderlineWarn = {undercurl = true, sp = palette.yellow}
  theme.highlights.DiagnosticUnderlineInfo = {undercurl = true, sp = palette.blue}
  theme.highlights.DiagnosticUnderlineHint = {undercurl = true, sp = palette.cyan}

  -- Git signs
  theme.highlights.GitSignsAdd = {fg = palette.green}
  theme.highlights.GitSignsChange = {fg = palette.yellow}
  theme.highlights.GitSignsDelete = {fg = palette.red}

  return theme
end

-- Generate a new theme with given preset and type
-- @param preset string: preset name
-- @param theme_type string: "dark" or "light"
-- @return table: complete theme
function M.create_theme(preset, theme_type)
  local is_dark = theme_type == "dark"
  local palette = presets.generate(preset, is_dark)
  return M.generate_theme(palette, theme_type)
end

return M
