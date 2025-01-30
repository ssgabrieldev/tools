local float_opts = {
  enter = true,
  position = "center",
  border = vim.g.border_style
}

local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      opts = {
        expand_lines = false
      }
    },
    "nvim-neotest/nvim-nio",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-dap.nvim",
    'akinsho/toggleterm.nvim',
    "rcarriga/nvim-notify",
  },
  init = function()
    local dap = require("dap")

    local js_debugger = { "pwa-chrome", "pwa-node" }
    for _, debugger in ipairs(js_debugger) do
      dap.adapters[debugger] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        protocol = "inspector",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
          args = { "${port}" },
        }
      }
    end

    dap.listeners.before.attach.dapui_config = function()
      vim.notify("Debugger attatched", "info")
    end
    dap.listeners.before.launch.dapui_config = function()
      vim.notify("Debugger launched", "info")
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      vim.notify("Debugger teminated", "info")
    end
    dap.listeners.before.event_exited.dapui_config = function()
      vim.notify("Debugger exited", "info")
    end
  end,
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debugger toggle breakpoint"
    },
    {
      "<leader>de",
      function()
        require("dap").terminate()
      end,
      desc = "Debugger terminate"
    },
    {
      "<leader>dr",
      function()
        require("dap").continue()
      end,
      desc = "Debugger continue"
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle({ reset = true })
      end,
      desc = "Debugger ui"
    },
    {
      "<leader>dv",
      function()
        require("dapui").eval({ enter = true })
      end,
      mode = { "n", "v" },
      desc = "Debugger evaluate",
    },
    {
      "<leader>dc",
      function()
        require("dapui").float_element("console", float_opts)
      end,
      desc = "Debugger console"
    },
    {
      "<leader>dw",
      function()
        require("dapui").float_element("watches", float_opts)
      end,
      desc = "Debugger watches"
    },
    {
      "<leader>dd",
      function()
        require("dapui").float_element("breakpoints", float_opts)
      end,
      desc = "Debugger breakpoints"
    },
    {
      "<leader>dl",
      function()
        require("dapui").float_element(nil, float_opts)
      end,
      desc = "Debugger list frames"
    },
  },
}

return M
