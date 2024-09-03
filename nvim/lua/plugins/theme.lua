local M = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "darker",
      -- transparent = true
    })
    require('onedark').load()
  end
}

return M
