local api = vim.api

local M = {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    persist_size = false,
    persist_mode = true,
    shade_terminals = false,
    float_opts = {
      border = vim.g.border_style,
      title_pos = "center",
      winblend = 3,
    },
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return " " .. (term.display_name or ("terminal " .. term.id))
      end
    }
  },
  keys = {
    {
      '<leader>tt',
      function()
        vim.cmd(vim.v.count .. "ToggleTerm direction=horizontal")
      end,
      mode = { "n", "t" },
      { desc = 'Toggle terminal' }
    },
    {
      '<leader>tf',
      function()
        vim.cmd(vim.v.count .. "ToggleTerm direction=float")
      end,
      mode = { "n", "t" },
      { desc = 'Toggle terminal' }
    }
  }
}

return M
