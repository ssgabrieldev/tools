return {
  get_theme = function()
    local config_path = vim.fn.stdpath('config')
    local theme_file = config_path .. '/user/theme.txt'

    local file = io.open(theme_file, 'r')
    if file then
      local theme = file:read('*line')
      file:close()

      if theme and theme ~= '' then
        return theme
      end
    else
      print('Error: Could not read ' .. theme_file)
    end
  end
}
