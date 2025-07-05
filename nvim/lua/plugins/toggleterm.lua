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
        local window_id = term.window

        if api.nvim_win_is_valid(window_id) then
          local window_buf = api.nvim_win_get_buf(term.window)
          return (term.bufnr == window_buf and "%#TabLineSel# " or "%#TabLine# ") .. (term.display_name or term.name) .. " %*"
        else
          return "%#TabLine# " .. (term.display_name or term.name) .. " %*"
        end
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
    }
  }
}

return M
