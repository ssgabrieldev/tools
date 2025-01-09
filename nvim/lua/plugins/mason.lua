local M = {
  "williamboman/mason.nvim",
  event = "BufEnter"
}

function M.config()
  require("mason").setup({
    ui = {
      border = vim.g.border_style
    }
  })
end

return M
