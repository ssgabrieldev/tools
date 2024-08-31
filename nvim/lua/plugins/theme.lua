local M = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "darker"
    })
    require('onedark').load()
  end
}

return M
