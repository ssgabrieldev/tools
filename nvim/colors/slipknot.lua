local lush = require("lush")
local theme = require("themes.slipknot")

vim.opt.background = 'dark'
vim.g.colors_name = 'slipknot'
package.loaded['themes.slipknot'] = nil

vim.api.nvim_create_autocmd("WinNew", {
  callback = function()
    vim.defer_fn(function()
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_buf_get_option(buf, "filetype")

      if ft == "toggleterm" then
        vim.api.nvim_set_hl(
          0,
          "TerminalBuffer",
          {
            fg = theme.theme.TerminalBuffer.fg.hex,
            bg = theme.theme.TerminalBuffer.bg.hex
          }
        )

        vim.api.nvim_set_option_value("winhighlight", "Normal:TerminalBuffer", { scope = "local" })
      end
    end, 10)
  end,
})

local function update_statusline_bg()
  local mode = vim.fn.mode()
  local color = theme.colors.lualine_normal_bg.hex

  if mode:find('i') then
    color = theme.colors.lualine_insert_bg.hex
  elseif mode:find('v') or mode:find('V') or mode == '' then
    color = theme.colors.lualine_visual_bg.hex
  elseif mode:find('R') then
    color = theme.colors.lualine_replace_bg.hex
  elseif mode:find('c') then
    color = theme.colors.lualine_command_bg.hex
  end

  vim.api.nvim_set_hl(0, 'StatusLine', { bg = color, fg = '#1e1e2e' })
end
update_statusline_bg()
vim.api.nvim_create_autocmd('ModeChanged', {
  callback = update_statusline_bg,
})

lush(theme.theme)
