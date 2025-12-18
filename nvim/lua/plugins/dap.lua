return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "igorlfs/nvim-dap-view" },
    "nvim-neotest/nvim-nio",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-tree.lua",
  },
  init = function()
    local dap = require("dap")

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = '', linehl = '', numhl = '' })

    local js_debugger = { "pwa-chrome", "pwa-node" }
    for _, debugger in ipairs(js_debugger) do
      dap.adapters[debugger] = function(cb)
        local adap = {
          type = "server",
          host = "localhost",
          port = "${port}",
          protocol = "inspector",
          executable = {
            command = "js-debug-adapter",
            args = { "${port}" },
          }
        }

        cb(adap)
      end
    end

    dap.adapters.firefox = function(cb, config)
      if config.preLaunchTask then
        vim.fn.system(config.preLaunchTask)
      end

      cb({
        type = "executable",
        command = "firefox-debug-adapter",
      })
    end

    dap.listeners.before.attach.dapui_config = function()
      vim.notify("Debugger attatched", "info")
    end
    dap.listeners.before.launch.dapui_config = function()
      vim.notify("Debugger launched", "info")
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
        require("dap").terminate({
          on_done = function()
            vim.notify("Debugger teminated", "info")
          end
        })
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
      "<leader>dw",
      function()
        require("dap-view").add_expr()
      end,
      mode = { "v", "n" },
      desc = "Debugger add expression"
    },
    {
      "<leader>dh",
      function()
        require("dap.ui.widgets").hover(nil, { border = vim.g.border_style})
      end,
      mode = { "v", "n" },
      desc = "Debugger add expression"
    },
    {
      "<leader>du",
      function()
        require("dap-view").toggle()
      end,
      mode = { "n" },
      desc = "Debugger toggle ui"
    },
  },
}
