local lazysql_terminal = nil
local lazygit_terminal = nil
local vimongo_terminal = nil

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
      enabled = true,
      name_formatter = function(term)
        return term.name
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
      { desc = 'Toggle terminal horizontal' }
    },
    {
      '<leader>ta',
      function()
          vim.cmd("ToggleTermToggleAll")
      end,
      mode = { "n", "t" },
      { desc = 'Toggle all terminal' }
    },
    {
      '<leader>tf',
      function()
        vim.cmd(vim.v.count .. "ToggleTerm direction=float")
      end,
      mode = { "n", "t" },
      { desc = 'Toggle terminal float' }
    },
    {
      "<leader>tm",
      function()
        if not vimongo_terminal then
          local Terminal = require('toggleterm.terminal').Terminal
          vimongo_terminal = Terminal:new({
            cmd = "vi-mongo",
            hidden = true,
            count = 1000,
            on_exit = function()
              vimongo_terminal = nil
            end
          })
        end

        vimongo_terminal:toggle();
      end,
      mode = { "n", "t" },
      { desc = "Vi-mongo" }
    },
    {
      "<leader>td",
      function()
        if not lazysql_terminal then
          local Terminal = require('toggleterm.terminal').Terminal
          lazysql_terminal = Terminal:new({
            cmd = "lazysql",
            hidden = true,
            count = 1001,
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
            count = 1002,
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
