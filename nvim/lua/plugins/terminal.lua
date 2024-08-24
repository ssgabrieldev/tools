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
    {
      '<leader>tt',
      function()
        vim.cmd(vim.v.count .. "ToggleTerm direction=horizontal")

        local tree_module = "nvim-tree"
        if package.loaded[tree_module] and require(tree_module .. ".view").is_visible() then
          local tree_focus_command = "NvimTreeFocus"
          local tree_resize_command = "NvimTreeResize 30"
          vim.cmd(tree_focus_command)
          vim.cmd("wincmd H")
          vim.cmd("wincmd p")
          vim.cmd(tree_resize_command)
        end

        local dap_module = "dapui"
        if package.loaded[dap_module] then
          require(dap_module).close()
        end
      end,
      mode = { "n", "t" },
      { desc = 'Toggle terminal horizontal' }
    },
  }
}

return M
