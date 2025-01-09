local lazysql_terminal = nil
local lazygit_terminal = nil

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
    {
      "<leader>td",
      function()
        if not lazysql_terminal then
          local Terminal = require('toggleterm.terminal').Terminal
          lazysql_terminal = Terminal:new({
            cmd = "lazysql",
            hidden = true,
            on_exit = function()
              lazysql_terminal = nil
            end
          })
        end

        lazysql_terminal:toggle();
      end,
      mode = { "n", "t" },
      { desc = "Lazysql" }
    },
    {
      "<leader>tg",
      function()
        if not lazygit_terminal then
          local Terminal = require('toggleterm.terminal').Terminal
          lazygit_terminal = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            on_exit = function()
              lazygit_terminal = nil
            end
          })
        end

        lazygit_terminal:toggle();
      end,
      mode = { "n", "t" },
      { desc = "Lazysql" }
    }
  }
}

return M
