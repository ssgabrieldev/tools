local float_opts = {
  enter = true,
  position = "center",
  border = vim.g.border_style
}

return {
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
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-tree.lua",
    "s1n7ax/nvim-window-picker",
    "akinsho/toggleterm.nvim",
  },
  init = function()
    local dap = require("dap")

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = '', linehl = '', numhl = '' })

    local js_debugger = { "pwa-chrome", "pwa-node" }
    for _, debugger in ipairs(js_debugger) do
      dap.adapters[debugger] = function(cb, config)
        if config.preLaunchTask then
          local Terminal = require("toggleterm.terminal").Terminal
          local terminal = Terminal:new({
            cmd = config.preLaunchTask,
            hidden = false,
            close_on_exit = false
          })

          terminal:toggle()
        end

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
        require("dap").terminate({
          on_done = function()
            vim.notify("Debugger teminated", "info")
          end
        })
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
      "<leader>du",
      function()
        require("dapui").toggle({ reset = true })
      end,
      desc = "Debugger ui"
    },
    {
      "<leader>dv",
      function()
        require("dapui").eval(nil, { enter = true })
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
    {
      "<leader>di",
      function()
        local win_id = require("window-picker").pick_window({
          filter_rules = {
            autoselect_one = true,
            bo = {
              filetype = {
                "NvimTree",
                "toggleterm",
                "dapui_watches",
                "dapui_stacks",
                "dapui_breakpoints",
                "dapui_scopes",
                "dapui_console",
                "dap-repl",
                "notify"
              }
            }
          }
        })

        if not win_id then
          return
        end

        vim.api.nvim_set_current_win(win_id)
        vim.cmd("e .vscode/launch.json")
      end,
      desc = "Debugger init"
    }
  },
}
