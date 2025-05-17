local lush = require('lush')
local hsl = lush.hsl
local utils_ui = require("plugins.utils.ui")

local M = {}

M.palette = {
  black = hsl(utils_ui.get_transparency() and "#000000" or "#080808"),
  red = hsl("#910c1a"),
  white = hsl("#F3F1EE"),
  gray = hsl("#5B5B5B"),
  yellow = hsl("#BC9909"),
  blue = hsl("#17699A"),
}
M.colors = {
  -- Editor
  bg = M.palette.black,
  bg_light = M.palette.black.li(2),
  bg_dark = M.palette.black.da(70),
  fg = M.palette.gray,
  fg_dark = M.palette.gray.da(60),
  keyword = M.palette.red,
  string = M.palette.red,
  number = M.palette.white,
  boolean = M.palette.white,
  parameter = M.palette.yellow,
  delimiter = M.palette.gray.li(60),
}

-- Lualine
M.colors.lualine_normal_bg = M.colors.bg_light
M.colors.lualine_normal_fg = M.palette.red
M.colors.lualine_insert_bg = M.palette.red
M.colors.lualine_insert_fg = M.colors.bg_light
M.colors.lualine_terminal_bg = M.palette.red
M.colors.lualine_terminal_fg = M.colors.bg_light
M.colors.lualine_visual_bg = M.palette.yellow
M.colors.lualine_visual_fg = M.colors.bg_light
M.colors.lualine_replace_bg = M.palette.yellow
M.colors.lualine_replace_fg = M.colors.bg_light
M.colors.lualine_command_bg = M.palette.blue
M.colors.lualine_command_fg = M.colors.bg_light
M.colors.lualine_inactive_bg = M.colors.bg_light
M.colors.lualine_inactive_fg = M.palette.white

-- NvimTree
M.colors.folder_name = M.colors.fg

M.theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  return {
    -- Common
    Normal { fg = M.colors.fg, bg = M.colors.bg },
    EndOfBuffer { fg = M.colors.bg, bg = M.colors.bg },
    Visual { fg = M.colors.bg, bg = M.colors.fg },
    CursorLine { bg = M.colors.bg_light },
    Directory { fg = M.colors.folder_name },

    -- Types
    Type { fg = M.colors.keyword },
    String { fg = M.colors.string },
    Number { fg = M.colors.number },
    Boolean { fg = M.colors.boolean },

    -- Identifier
    Identifier { fg = M.colors.keyword },
    keyword { fg = M.colors.keyword },
    Function { fg = M.colors.delimiter },
    Comment { fg = M.colors.fg_dark },
    Statement { fg = M.colors.keyword },

    -- Delimiter
    Delimiter { fg = M.colors.delimiter },
    Special { fg = M.colors.delimiter },

    -- NvimTree
    NvimTreeNormal { bg = M.colors.bg_dark },
    NvimTreeNormalNC { bg = M.colors.bg_dark },
    NvimTreeEndOfBuffer { bg = M.colors.bg_dark, fg = M.colors.bg_dark },
    NvimTreeVertSplit { bg = M.colors.bg_dark, fg = M.colors.bg_dar },
    NvimTreeWinSeparator { bg = M.colors.bg_dark, fg = M.colors.bg_dark },
    NvimTreeFolderName { fg = M.colors.folder_name },
    NvimTreeOpenedFolderName { fg = M.colors.folder_name },

    -- Terminal
    TerminalBuffer { bg = M.colors.bg_dark, fg = M.colors.fg },

    -- TreeSitter Comon
    sym("@keyword") { fg = M.colors.keyword },

    -- TreeSitter Types
    sym("@string") { fg = M.colors.string },
    sym("@number") { fg = M.colors.number },
    sym("@boolean") { fg = M.colors.boolean },

    -- TreeSitter Identifier
    sym("@variable") { fg = M.colors.fg },
    sym("@variable.parameter") { fg = M.colors.parameter },
    sym("@function") { fg = M.colors.keyword },
    sym("@function.method") { fg = M.colors.keyword },
    sym("@function.builtin") { fg = M.colors.keyword },
    sym("@method") { fg = M.colors.keyword },

    -- Lsp
    sym("@lsp.type.property") { fg = M.colors.fg },

    -- Typescript
    typescriptParens { fg = M.colors.delimiter }
  }
end)

return M
