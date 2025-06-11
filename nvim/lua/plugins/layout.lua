return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    animate = {
      enabled = false
    },
    left = {
      {
        ft = "NvimTree"
      },
      {
        ft = "dapui_watches"
      },
      {
        ft = "dapui_stacks"
      },
      {
        ft = "dapui_breakpoints"
      },
      {
        ft = "dapui_scopes"
      }
    },
    bottom = {
      {
        ft = "toggleterm",
        size = { height = 15 },
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end
      },
      {
        ft = "dapui_console"
      },
      {
        ft = "dap-repl"
      }
    },
  }
}
