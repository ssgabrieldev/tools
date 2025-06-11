local utils = require("plugins.utils.utils")

local lazysql_terminal = nil
local lazygit_terminal = nil
local vimongo_terminal = nil

local close_other_panels = function()
  utils.close_buffers({
    "dap-view",
    "dap-view-term",
  })
end

local close_all_terms = function()
  local terms = require("toggleterm.terminal").get_all()

  for _, term in ipairs(terms) do
    term:close()
  end
end

local open_new_terminal = function()
  vim.ui.select(
    { "horizontal", "float" },
    {
      prompt = "New terminal direction"
    },
    function(choise)
      if choise then
        vim.ui.input(
          {
            prompt = "Terminal name: ",
          },
          function(input)
            if input == nil or input == "" then
              input = string.char(math.random(97, 122))
            end

            close_all_terms()

            require('toggleterm.terminal').Terminal:new({
              hidden = false,
              display_name = input,
              direction = choise,
              on_open = close_other_panels
            }):open()
          end
        )
      end
    end
  )
end

local M = {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    shade_terminals = false,
    shading_factor = "-70",
    shading_ratio = "-0.5", -- the ratio of shading factor for light/dark terminal background, default: -3
    float_opts = {
      border = vim.g.border_style,
      title_pos = "center",
      winblend = 3,
      width = 1000,
      height = 1000
    },
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.display_name or term.name
      end
    },
    highlights = {
      Normal = {
        link = "NormalFloat"
      },
      NormalFloat = {
        link = "NormalFloat"
      }
    }
  },
  keys = {
    {
      '<leader>tt',
      function()
        local terms = require("toggleterm.terminal").get_all()

        if #terms == 0 then
          open_new_terminal()
        else
          close_other_panels()
          vim.cmd("ToggleTerm")
        end
      end,
      mode = { "n", "t", "i" },
      { desc = 'Toggle terminal' }
    },
    {
      '<leader>tn',
      function()
        open_new_terminal()
      end,
      mode = { "n", "t", "i" },
      { desc = 'Create terminal' }
    },
    {
      '<leader>tr',
      function()
        vim.cmd("ToggleTermSetName")
      end,
      mode = { "n", "t", "i" },
      { desc = 'Rename terminal' }
    },
    {
      "<leader>ft",
      function()
        local terms = require("toggleterm.terminal").get_all()

        vim.ui.select(
          terms,
          {
            prompt = "Search Terminal",
            format_item = function(term)
              return "" .. term.id .. " " .. term.display_name or term.name
            end
          },
          function(term_choice)
            if (term_choice) then
              close_all_terms()
              close_other_panels()

              term_choice:open()
            end
          end
        )
      end,
      mode = { "n", "t", "i" },
      { desc = "Find terminals" }
    },
    {
      "<leader>tm",
      function()
        if not vimongo_terminal then
          local Terminal = require('toggleterm.terminal').Terminal
          vimongo_terminal = Terminal:new({
            cmd = "vmd",
            direction = "float",
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
            direction = "float",
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
            direction = "float",
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
