local utils_buffers = require("plugins.utils.buffers")

local M = {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    direction = "horizontal",
    float_opts = {
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
        utils_buffers.close_for_terminal(function()
          vim.cmd(vim.v.count .. "ToggleTerm")
        end)
      end,
      mode = { "n", "t" },
      { desc = 'Toggle terminal horizontal' }
    },
  }
}

return M
