local M = {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme carbonfox")
  end
}

return M
