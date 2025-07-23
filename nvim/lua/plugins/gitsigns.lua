local vim = vim

return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = function()
    require('gitsigns').setup({
      current_line_blame = true
    })
  end,
  keys = {
    {
      "<leader>tg",
      function()
        vim.cmd("Gitsigns toggle_linehl")
        vim.cmd("Gitsigns toggle_deleted")
      end,
      mode = { "n" },
      { desc = "Toggle Git Diff" }
    }
  }
}
