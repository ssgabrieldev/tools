local lush = require('lush')
local hsl = lush.hsl

local M = {}

M.palette = {
  black = hsl("#080808"),
  red = hsl("#910c1a"),
  white = hsl("#F3F1EE"),
  gray = hsl("#5B5B5B"),
  yellow = hsl("#BC9909"),
  blue = hsl("#17699A"),
  green = hsl("#5A715E")
}
M.colors = {
  -- Editor
  bg = M.palette.black,
  bg_light = M.palette.black.li(2),
  bg_dark = M.palette.black.da(70),
  fg = M.palette.gray,
  fg_dark = M.palette.gray.da(30),
  keyword = M.palette.red,
  string = M.palette.red,
  number = M.palette.white,
  boolean = M.palette.white,
  parameter = M.palette.gray,
  delimiter = M.palette.gray.li(60),
  cmd_fg = M.palette.blue,
}

-- Diagnostic
M.colors.diagnostic_info_fg = M.palette.blue
M.colors.diagnostic_info_bg = M.colors.diagnostic_info_fg.da(80)
M.colors.diagnostic_warn_fg = M.palette.yellow
M.colors.diagnostic_warn_bg = M.colors.diagnostic_warn_fg.da(80)
M.colors.diagnostic_error_fg = M.palette.red
M.colors.diagnostic_error_bg = M.colors.diagnostic_error_fg.da(80)
M.colors.diagnostic_hint_fg = M.palette.blue
M.colors.diagnostic_hint_bg = M.colors.diagnostic_hint_fg.da(80)

-- FloatBorder
M.colors.border_fg = M.colors.bg
M.colors.border_bg = M.colors.bg_dark

-- BufferLine
M.colors.buffer_selected = M.palette.white

-- Lualine
M.colors.lualine_normal_bg = M.colors.bg_dark
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
M.colors.lualine_inactive_bg = M.colors.bg_dark
M.colors.lualine_inactive_fg = M.palette.white

-- NvimTree
M.colors.folder_name = M.colors.fg

-- Diff
local diff_da = 80
M.colors.diff_add_fg = M.palette.green
M.colors.diff_delete_fg = M.palette.red
M.colors.diff_change_fg = M.palette.blue
M.colors.diff_add_bg = M.palette.green.da(diff_da)
M.colors.diff_delete_bg = M.palette.red.da(diff_da)
M.colors.diff_change_bg = M.palette.blue.da(diff_da)

-- Markdown
M.colors.markdown_code_block_bg = M.colors.bg_dark

-- Dap
M.colors.dap_stopped_line_bg = M.palette.red.da(60)
M.colors.dap_stopped_icon_fg = M.palette.red

M.theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  return {
    -- Common
    Normal { fg = M.colors.fg, bg = M.colors.bg },
    EndOfBuffer { fg = M.colors.bg, bg = M.colors.bg },
    Visual { fg = M.colors.bg, bg = M.colors.fg },
    CursorLine { bg = M.colors.bg_light },
    Directory { fg = M.colors.folder_name },
    NormalFloat { fg = M.colors.fg, bg = M.colors.bg_dark }, -- Normal text in floating windows.
    FloatBorder { fg = M.colors.border_fg, bg = M.colors.border_bg },
    WinSeparator { bg = M.colors.border_bg, fg = M.colors.border_fg },
    StatusLine { bg = M.colors.lualine_inactive_bg },
    StatusLineNC { bg = M.colors.lualine_inactive_bg },
    DiffAdd { fg = M.colors.diff_add_fg, bg = M.colors.diff_add_bg },
    DiffDelete { fg = M.colors.diff_delete_fg, bg = M.colors.diff_delete_bg },
    DiffChange { fg = M.colors.diff_change_fg, bg = M.colors.diff_change_bg },
    Added { fg = M.colors.diff_add_fg, bg = M.colors.diff_add_bg },
    Removed { fg = M.colors.diff_delete_fg, bg = M.colors.diff_delete_bg },
    Changed { fg = M.colors.diff_change_fg, bg = M.colors.diff_change_bg },

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
    htmlTagName { fg = M.colors.fg },

    -- Delimiter
    Delimiter { fg = M.colors.delimiter },
    Special { fg = M.colors.delimiter },

    -- Gitsigns
    GitSignsAdd { DiffAdd, bg = "" },
    GitSignsDelete { DiffDelete, bg = "" },
    GitSignsChange { DiffChange, bg = "" },

    -- Diagnostic
    DiagnosticInfo { fg = M.colors.diagnostic_info_fg },
    DiagnosticWarn { fg = M.colors.diagnostic_warn_fg },
    DiagnosticError { fg = M.colors.diagnostic_error_fg },
    DiagnosticHint { fg = M.colors.diagnostic_info_fg },
    DiagnosticSignInfo { DiagnosticInfo, gui = "NONE" },
    DiagnosticSignWarn { DiagnosticWarn, gui = "NONE" },
    DiagnosticSignError { DiagnosticError, gui = "NONE" },
    DiagnosticSignHint { DiagnosticHint, gui = "NONE" },
    DiagnosticVirtualTextInfo { DiagnosticInfo, bg = M.colors.diagnostic_info_bg },
    DiagnosticVirtualTextWarn { DiagnosticWarn, bg = M.colors.diagnostic_warn_bg },
    DiagnosticVirtualTextError { DiagnosticError, bg = M.colors.diagnostic_error_bg },
    DiagnosticVirtualTextHint { DiagnosticHint, bg = M.colors.diagnostic_info_bg },
    DiagnosticUnderlineInfo { gui = "undercurl", sp = M.colors.diagnostic_info_fg },
    DiagnosticUnderlineWarn { gui = "undercurl", sp = M.colors.diagnostic_warn_fg },
    DiagnosticUnderlineError { gui = "undercurl", sp = M.colors.diagnostic_error_fg },
    DiagnosticUnderlineHint { gui = "undercurl", sp = M.colors.diagnostic_hint_fg },
    ErrorMsg { DiagnosticError },
    WarningMsg { DiagnosticWarn },

    -- Dap
    debugPC { bg = M.colors.dap_stopped_line_bg },
    SignColumn { fg = M.colors.dap_stopped_icon_fg },
    DapNormal { NormalFloat },
    DapEndOfBuffer { NormalFloat, fg = NormalFloat.bg },
    NvimDapViewTab { NormalFloat },

    -- NvimTree
    NvimTreeNormal { bg = M.colors.bg_dark },
    NvimTreeNormalNC { bg = M.colors.bg_dark },
    NvimTreeEndOfBuffer { bg = M.colors.bg_dark, fg = M.colors.bg_dark },
    NvimTreeVertSplit { WinSeparator },
    NvimTreeWinSeparator { WinSeparator },
    NvimTreeFolderName { fg = M.colors.folder_name },
    NvimTreeOpenedFolderName { fg = M.colors.folder_name },

    -- Noice
    NoiceCmdline { fg = M.colors.cmd_fg, bg = M.colors.bg_dark },
    NoiceCmdlineIcon { fg = M.colors.cmd_fg, bg = M.colors.bg_dark },
    NoiceCmdlinePopup { fg = M.colors.cmd_fg, bg = M.colors.bg_dark },
    NoiceCmdlineIconLua { fg = M.colors.cmd_fg, bg = M.colors.bg_dark },
    NoiceCmdlinePopupBorderLua { FloatBorder },
    NoiceCmdlinePopupBorderInput { FloatBorder },
    NoiceCmdlinePopupBorderSearch { FloatBorder },
    NoiceCmdlinePopupBorderCmdline { FloatBorder },

    -- BufferLine
    BufferLineOffsetSeparator { NvimTreeWinSeparator },
    BufferLineFill { NvimTreeWinSeparator },
    BufferLineBufferSelected { fg = M.colors.buffer_selected },

    -- Telescope
    TelescopeNormal { NormalFloat },
    TelescopeBorder { FloatBorder },

    -- Terminal
    TerminalBuffer { bg = M.colors.bg_dark, fg = M.colors.fg },

    -- Markdown
    RenderMarkdownCode { bg = M.colors.markdown_code_block_bg },

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dap-view", "dap-repl", "dap-view-term" },
  callback = function()
    vim.api.nvim_buf_set_option(0, "winhighlight", "Normal:DapNormal")
    vim.api.nvim_buf_set_option(0, "winhighlight", "EndOfBuffer:DapEndOfBuffer")
  end,
})

return M
