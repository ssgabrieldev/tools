local border = vim.g.border_style

return {
  "williamboman/mason.nvim",
  event = "BufEnter",
  config = function()
    require("mason").setup({
      ui = {
        border = border
      }
    })
  end
}
