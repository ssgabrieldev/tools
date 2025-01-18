local M = {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true
      }
    })
    vim.cmd("colorscheme nightfox")
  end
}

return M
