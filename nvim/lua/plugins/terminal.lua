local M = {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    direction = "float",
    float_opts = {
      title_pos = "center",
      winblend = 3
    },
    winbar = {
      enabled = true,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    }
  },
  keys = {
    { '<leader>tf', ':ToggleTerm direction=float<CR>', { desc = 'Toggle terminal float' } },
    {
      '<leader>tt',
      function()
        local tree_command = ":NvimTreeToggle"
        if vim.fn.exists(tree_command) > 0 then
          vim.cmd(tree_command)
        end

        vim.cmd(vim.v.count .. "ToggleTerm direction=horizontal")

        if vim.fn.exists(tree_command) > 0 then
          vim.cmd(tree_command)
          vim.cmd("wincmd b")
        end
      end,
      { desc = 'Toggle terminal horizontal' }
    },
  }
}

return M
