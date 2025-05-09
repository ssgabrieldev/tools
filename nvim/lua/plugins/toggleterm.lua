local toggleterm_utils = require("plugins.utils.toggleterm")

local lazysql_terminal = nil
local lazygit_terminal = nil
local vimongo_terminal = nil

local M = {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    direction = "float",
    shade_terminals = true,
    float_opts = {
      border = vim.g.border_style,
      title_pos = "center",
      winblend = 3,
      width = 1000,
      height = 1000
    },
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return term.display_name or term.name
      end
    }
  },
  keys = {
    {
      '<leader>tt',
      function()
        local terminals = require("toggleterm.terminal").get_all()

        if #terminals > 0 then
          vim.cmd(vim.v.count .. "ToggleTerm")
        else
          toggleterm_utils.open_new_terminal()
        end
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
      '<leader>tn',
      function()
        toggleterm_utils.open_new_terminal()
      end,
      mode = { "n", "t" },
      { desc = 'Set terminal name' }

    },
    {
      '<leader>t<s-n>',
      function()
        vim.cmd("ToggleTermSetName")
      end,
      mode = { "n", "t" },
      { desc = 'Set terminal name' }
    },
    {
      "<leader>tm",
      function()
        if not vimongo_terminal then
          local Terminal = require('toggleterm.terminal').Terminal
          vimongo_terminal = Terminal:new({
            cmd = "vmd",
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
            cmd = "lsql",
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
            cmd = "lg",
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
      { desc = "Lazygit" }
    }
  }
}

return M
