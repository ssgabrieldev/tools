local M = {
  "terrortylor/nvim-comment",
  keys = {
    { "<leader>/", ":CommentToggle<cr>", desc = "Comment line", mode = {"v", "n"} },
  },
  config = function()
    require('nvim_comment').setup()
  end
}

return M
