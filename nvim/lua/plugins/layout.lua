return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    wo = {
      winbar = false,
      winfixwidth = true,
      winfixheight = true
    },
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
    right = {
      {
        ft = "qf"
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
    keys = {
      ["<a-j>"] = function(win)
        win:resize("height", -2)
      end,
      ["<a-k>"] = function(win)
        win:resize("height", 2)
      end,
      ["<a-h>"] = function(win)
        win:resize("width", -2)
      end,
      ["<a-l>"] = function(win)
        win:resize("width", 2)
      end,
    }
  }
}
