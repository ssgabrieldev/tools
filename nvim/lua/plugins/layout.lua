return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    wo = {
      winfixwidth = false
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
        ft = "toggleterm"
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

