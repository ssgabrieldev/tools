local lush = require('lush')
local hsl = lush.hsl
local utils_ui = require("plugins.utils.ui")

local palette = {
  black = hsl(utils_ui.get_transparency() and "#000000" or "#080808"),
  red = hsl("#F2000B"),
  white = hsl("#F3F1EE"),
  gray = hsl("#5B5B5B"),
  yellow = hsl("#BC9909"),
}
local colors = {
  bg = palette.black,
  bg_light = palette.black.li(2),
  bg_dark = palette.black.da(70),
  fg = palette.gray,
  fg_dark = palette.gray.da(60),
  keyword = palette.red,
  string = palette.red.da(60),
  number = palette.white,
  boolean = palette.white,
  parameter = palette.yellow,
  delimiter = palette.white,
}

colors.folder_name = colors.fg

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  return {
    -- Common
    Normal { fg = colors.fg, bg = colors.bg },
    EndOfBuffer { fg = colors.bg, bg = colors.bg },
    Visual { fg = colors.bg, bg = colors.fg },
    CursorLine { bg = colors.bg_light },
    Directory { fg = colors.folder_name },

    -- Types
    String { fg = colors.string },
    Number { fg = colors.number },
    Boolean { fg = colors.boolean },

    -- Identifier
    Identifier { fg = colors.fg },
    keyword { fg = colors.keyword },
    Function { fg = colors.delimiter },
    Comment { fg = colors.fg_dark },
    Statement { fg = colors.keyword },

    -- Delimiter
    Delimiter { fg = colors.delimiter },
    Special { fg = colors.delimiter },

    -- NvimTree
    NvimTreeNormal { bg = colors.bg_dark },
    NvimTreeNormalNC { bg = colors.bg_dark },
    NvimTreeEndOfBuffer { bg = colors.bg_dark, fg = colors.bg_dark },
    NvimTreeVertSplit { bg = colors.bg_dark, fg = colors.bg_dar },
    NvimTreeWinSeparator { bg = colors.bg_dark, fg = colors.bg_dark },
    NvimTreeFolderName { fg = colors.folder_name },
    NvimTreeOpenedFolderName { fg = colors.folder_name },

    -- Terminal
    TerminalBuffer { bg = colors.bg_dark, fg = colors.fg },

    -- TreeSitter Comon
    sym("@keyword") { fg = colors.keyword },

    -- TreeSitter Types
    sym("@string") { fg = colors.string },
    sym("@number") { fg = colors.number },
    sym("@boolean") { fg = colors.boolean },

    -- TreeSitter Identifier
    sym("@variable") { fg = colors.fg },
    sym("@variable.parameter") { fg = colors.parameter },
    -- sym("@function") { fg = colors.keyword },
    sym("@function.method") { fg = colors.keyword },
    sym("@function.builtin") { fg = colors.keyword },
    sym("@method") { fg = colors.keyword },
  }
end)

return theme
