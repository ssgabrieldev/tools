local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  keys = {
    {
      '<leader>gd',
      function()
        vim.cmd('Gitsigns diffthis')
      end,
      desc = 'Git diff this'
    }
  },
  config = function()
    require('gitsigns').setup({
      current_line_blame = true
    })
  end
}

return M
