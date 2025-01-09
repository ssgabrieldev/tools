local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = function()
    require('gitsigns').setup({
      current_line_blame = true
    })
  end
}

return M
