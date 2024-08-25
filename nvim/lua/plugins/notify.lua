local M = {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      stages = "static",
    })
  end
}

return M
