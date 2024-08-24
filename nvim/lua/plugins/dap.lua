local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "mxsdev/nvim-dap-vscode-js"
  },
  keys = {
    { "<leader>dt", ":DapToggleBreakpoint<cr>", desc = "Debugger breakpoint" },
    { "<leader>de", ":DapTerminate<cr>",        desc = "Debugger terminate" },
    { "<leader>dc", ":DapContinue<cr>",         desc = "Debugger continue" },
    {
      "<leader>du",
      function()
        local tree_module = "nvim-tree"
        if package.loaded[tree_module] then
          vim.cmd("NvimTreeClose")
        end

        local terminal_module = "toggleterm"
        if package.loaded[terminal_module] then
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.fn.bufwinid(bufnr) ~= -1 then
              if vim.bo[bufnr].filetype == "toggleterm" then
                vim.cmd("ToggleTermToggleAll")
              end
            end
          end
        end

        require("dapui").toggle({ reset = true })
      end,
      desc = "Debugger ui"
    },
    {
      "<leader>dv",
      function()
        require("dapui").eval()
      end,
      mode = { "n", "v" },
      desc = "Debugger evaluate",
    },
    {
      "<leader>dr",
      function()
        require("dapui").float_element("repl", { enter = true })
      end,
      desc = "Debugger repl"
    },
    {
      "<leader>dd",
      function()
        require("dapui").float_element("breakpoints", { enter = true })
      end,
      desc = "Debugger breakpoints"
    },
    {
      "<leader>dw",
      function()
        require("dapui").float_element("watches", { enter = true })
      end,
      desc = "Debugger open watcher"
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      protocol = "inspector",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
        args = { "${port}" },
      }
    }

    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      },
    }

    dap.adapters["firefox"] = {
      type = 'executable',
      command = vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
    }

    dap.configurations.javascriptreact = {
      {
        name = 'Launch Firefox',
        type = 'firefox',
        request = 'launch',
        reAttach = true,
        console = "integratedTerminal",
        webRoot = '${workspaceFolder}',
        firefoxExecutable = function ()
          return vim.fn.input("FIREFOX EXECUTABLE: ", '/usr/bin/firefox')
        end,
        url = function ()
          return vim.fn.input("APP URL: ", "http://localhost:3000")
        end
      }
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    dapui.setup()
  end
}

return M
