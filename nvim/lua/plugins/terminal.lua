local M = {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    direction = "float",
    float_opts = {
      border = vim.g.border_style,
      title_pos = "center",
      winblend = 3
    },
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end
    }
  },
  keys = {
    {
      '<leader>tt',
      function()
        vim.cmd(vim.v.count .. "ToggleTerm")
      end,
      mode = { "n", "t" },
      { desc = 'Toggle terminal' }
    },
  }
}

return M
