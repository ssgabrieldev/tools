local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio"
  },
  keys = {
    { "<leader>db", ":DapToggleBreakpoint<cr>", desc = "Debugger toggle breakpoint" },
    { "<leader>de", ":DapTerminate<cr>",        desc = "Debugger terminate" },
    { "<leader>dc", ":DapContinue<cr>",         desc = "Debugger continue" },
    {
      "<leader>dl",
      function()
        require("dap.ext.vscode").load_launchjs(
          nil,
          {
            ["node"] = { "javascript" }
          }
        )
      end,
      desc = "Debugger load configuration file"
    },
    {
      "<leader>dou",
      function()
        local tree_command = ":NvimTreeToggle"
        if vim.fn.exists(tree_command) > 0 then
          vim.cmd(tree_command)
        end

        require("dapui").toggle({ reset = true })

        if vim.fn.exists(tree_command) > 0 then
          vim.cmd(tree_command)
          vim.cmd("wincmd b")
        end
      end,
      desc = "Debugger toggle ui"
    },
    {
      "<leader>dov",
      function()
        require("dapui").eval()
      end,
      desc = "Debugger toggle ui",
      mode = "n"
    },
    {
      "<leader>dor",
      function()
        require("dapui").float_element("repl", { enter = true })
      end,
      desc = "Debugger open repl"
    },
    {
      "<leader>dob",
      function()
        require("dapui").float_element("breakpoints", { enter = true })
      end,
      desc = "Debugger open breakpoints"
    },
    {
      "<leader>dow",
      function()
        require("dapui").float_element("watches", { enter = true })
      end,
      desc = "Debugger open watcher"
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.adapters.node = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/node-debug2-adapter",
    }

    dap.configurations["javascript"] = {
      {
        name = "Node Launch",
        type = "node",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
      }
    }

    dapui.setup()
  end
}

return M
