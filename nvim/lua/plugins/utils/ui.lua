return {
  get_transparency = function()
    if vim.g.transparent ~= nil then
      return vim.g.transparent
    end

    local config_path = vim.fn.stdpath('config')
    local theme_file = config_path .. '/user/transparency.txt'
    local file = io.open(theme_file, 'r')

    if file then
      local content = file:read("*all")
      file:close()

      if not content then
        return false
      end

      vim.g.transparent = content:match("true") and true or false
      return vim.g.transparent
    end

    return false
  end,

  toggle_transparency = function()
    local file_path = vim.fn.expand("~/.config/nvim/user/transparency.txt")
    local file = io.open(file_path, "r")

    if file then
      local content = file:read("*all")

      vim.g.transparent = content:match("true")

      file:close()
    end

    file = io.open(file_path, "w")
    if file then
      vim.g.transparent = not vim.g.transparent

      if vim.g.transparent then
        file:write("true")
      else
        file:write("false")
      end

      file:close()
      print("Transparent set to: " .. (vim.g.transparent and "true" or "false"))
    end
  end
}
