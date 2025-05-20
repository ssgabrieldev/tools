local theme = require("themes.slipknot")

local function update_statusline_bg()
  if vim.g.colors_name == "slipknot" then
    local mode = vim.fn.mode()
    local bg_color = theme.colors.lualine_normal_bg.hex
    local fg_color = theme.colors.lualine_normal_fg.hex

    if mode:find('i') then
      fg_color = theme.colors.lualine_insert_fg.hex
      bg_color = theme.colors.lualine_insert_bg.hex
    elseif mode:find('v') or mode:find('V') or mode == '' then
      fg_color = theme.colors.lualine_visual_fg.hex
      bg_color = theme.colors.lualine_visual_bg.hex
    elseif mode:find('R') then
      fg_color = theme.colors.lualine_replace_fg.hex
      bg_color = theme.colors.lualine_replace_bg.hex
    elseif mode:find('c') then
      bg_color = theme.colors.lualine_command_bg.hex
      fg_color = theme.colors.lualine_command_fg.hex
    end


    vim.api.nvim_set_hl(0, 'StatusLine', { bg = bg_color, fg = fg_color })
  end
end
update_statusline_bg()
vim.api.nvim_create_autocmd('ModeChanged', {
  callback = update_statusline_bg,
})

return {
  normal = {
    a = { bg = theme.colors.lualine_normal_bg.hex, fg = theme.colors.lualine_normal_fg.hex },
    b = { bg = theme.colors.lualine_normal_bg.hex, fg = theme.colors.lualine_normal_fg.hex },
    c = { bg = theme.colors.lualine_normal_bg.hex, fg = theme.colors.lualine_normal_fg.hex },
    x = { bg = theme.colors.lualine_normal_bg.hex, fg = theme.colors.lualine_normal_fg.hex },
    y = { bg = theme.colors.lualine_normal_bg.hex, fg = theme.colors.lualine_normal_fg.hex },
    z = { bg = theme.colors.lualine_normal_bg.hex, fg = theme.colors.lualine_normal_fg.hex },
  },
  insert = {
    a = { bg = theme.colors.lualine_insert_bg.hex, fg = theme.colors.lualine_insert_fg.hex },
    b = { bg = theme.colors.lualine_insert_bg.hex, fg = theme.colors.lualine_insert_fg.hex },
    c = { bg = theme.colors.lualine_insert_bg.hex, fg = theme.colors.lualine_insert_fg.hex },
    x = { bg = theme.colors.lualine_insert_bg.hex, fg = theme.colors.lualine_insert_fg.hex },
    y = { bg = theme.colors.lualine_insert_bg.hex, fg = theme.colors.lualine_insert_fg.hex },
    z = { bg = theme.colors.lualine_insert_bg.hex, fg = theme.colors.lualine_insert_fg.hex },
  },
  terminal = {
    a = { bg = theme.colors.lualine_terminal_bg.hex, fg = theme.colors.lualine_terminal_fg.hex },
    b = { bg = theme.colors.lualine_terminal_bg.hex, fg = theme.colors.lualine_terminal_fg.hex },
    c = { bg = theme.colors.lualine_terminal_bg.hex, fg = theme.colors.lualine_terminal_fg.hex },
    x = { bg = theme.colors.lualine_terminal_bg.hex, fg = theme.colors.lualine_terminal_fg.hex },
    y = { bg = theme.colors.lualine_terminal_bg.hex, fg = theme.colors.lualine_terminal_fg.hex },
    z = { bg = theme.colors.lualine_terminal_bg.hex, fg = theme.colors.lualine_terminal_fg.hex },
  },
  visual = {
    a = { bg = theme.colors.lualine_visual_bg.hex, fg = theme.colors.lualine_visual_fg.hex },
    b = { bg = theme.colors.lualine_visual_bg.hex, fg = theme.colors.lualine_visual_fg.hex },
    c = { bg = theme.colors.lualine_visual_bg.hex, fg = theme.colors.lualine_visual_fg.hex },
    x = { bg = theme.colors.lualine_visual_bg.hex, fg = theme.colors.lualine_visual_fg.hex },
    y = { bg = theme.colors.lualine_visual_bg.hex, fg = theme.colors.lualine_visual_fg.hex },
    z = { bg = theme.colors.lualine_visual_bg.hex, fg = theme.colors.lualine_visual_fg.hex },
  },
  replace = {
    a = { bg = theme.colors.lualine_replace_bg.hex, fg = theme.colors.lualine_replace_fg.hex },
    b = { bg = theme.colors.lualine_replace_bg.hex, fg = theme.colors.lualine_replace_fg.hex },
    c = { bg = theme.colors.lualine_replace_bg.hex, fg = theme.colors.lualine_replace_fg.hex },
    x = { bg = theme.colors.lualine_replace_bg.hex, fg = theme.colors.lualine_replace_fg.hex },
    y = { bg = theme.colors.lualine_replace_bg.hex, fg = theme.colors.lualine_replace_fg.hex },
    z = { bg = theme.colors.lualine_replace_bg.hex, fg = theme.colors.lualine_replace_fg.hex },
  },
  command = {
    a = { bg = theme.colors.lualine_command_bg.hex, fg = theme.colors.lualine_command_fg.hex },
    b = { bg = theme.colors.lualine_command_bg.hex, fg = theme.colors.lualine_command_fg.hex },
    c = { bg = theme.colors.lualine_command_bg.hex, fg = theme.colors.lualine_command_fg.hex },
    x = { bg = theme.colors.lualine_command_bg.hex, fg = theme.colors.lualine_command_fg.hex },
    y = { bg = theme.colors.lualine_command_bg.hex, fg = theme.colors.lualine_command_fg.hex },
    z = { bg = theme.colors.lualine_command_bg.hex, fg = theme.colors.lualine_command_fg.hex },
  },
  inactive = {
    a = { bg = theme.colors.lualine_inactive_bg.hex, fg = theme.colors.lualine_inactive_fg.hex },
    b = { bg = theme.colors.lualine_inactive_bg.hex, fg = theme.colors.lualine_inactive_fg.hex },
    c = { bg = theme.colors.lualine_inactive_bg.hex, fg = theme.colors.lualine_inactive_fg.hex },
    x = { bg = theme.colors.lualine_inactive_bg.hex, fg = theme.colors.lualine_inactive_fg.hex },
    y = { bg = theme.colors.lualine_inactive_bg.hex, fg = theme.colors.lualine_inactive_fg.hex },
    z = { bg = theme.colors.lualine_inactive_bg.hex, fg = theme.colors.lualine_inactive_fg.hex },
  }
}
