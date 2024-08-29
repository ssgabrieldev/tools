local got_to_propper_win = function()
  if
      string.match(vim.bo.filetype, "dap")
      or vim.bo.filetype == "toggleterm"
  then
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local current_bufnr = vim.bo[bufnr]
      if vim.fn.bufwinid(bufnr) ~= -1 then
        if
            not string.match(current_bufnr.filetype, "dap")
            and current_bufnr.filetype ~= "toggleterm"
            and current_bufnr.filetype ~= "NvimTree"
        then
          vim.api.nvim_set_current_win(vim.fn.bufwinid(bufnr))
        end
      end
    end
  end
end

local setup_ui = function(init_ui)
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

  init_ui()
end

local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-dap.nvim"
  },
  keys = {
    {
      "<leader>db",
      function()
        vim.cmd("DapToggleBreakpoint")
      end,
      desc = "Debugger breakpoint"
    },
    {
      "<leader>de",
      function()
        vim.cmd("DapTerminate")
        -- require("dapui").close()
      end,
      desc = "Debugger terminate"
    },
    {
      "<leader>dc",
      function()
        got_to_propper_win()
        vim.cmd("DapContinue")
      end,
      desc = "Debugger continue"
    },
    {
      "<leader>du",
      function()
        setup_ui(function()
          require("dapui").toggle({ reset = true })
        end)
      end,
      desc = "Debugger ui"
    },
    {
      "<leader>dv",
      function()
        require("dapui").eval()
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

    local js = { "javascriptreact", "javascript" }
    for _, language in ipairs(js) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Node",
          runtimeExecutable = function()
            local executable = vim.fn.input("COMMAND: ", "")

            if executable == "" then
              return "node"
            end

            return executable
          end,
          runtimeArgs = function()
            local args = {}

            while true do
              local arg = vim.fn.input("COMMAND ARGS: ", "")

              if arg == "" then
                break
              end

              table.insert(args, arg)
            end

            if next(args) ~= nil then
              return args
            end

            return { "${file}" }
          end,
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Chrome - launch",
          runtimeExecutable = "/usr/bin/google-chrome",
          runtimeArgs = {},
          console = "integratedTerminal",
          sourceMaps = true,
          webRoot = function()
            return "${workspaceFolder}" .. vim.fn.input("WEB ROOT: ")
          end,
          remoteRoot = function()
            return "${workspaceFolder}" .. vim.fn.input("REMOTE ROOT: ")
          end,
          url = function()
            return vim.fn.input("APP URL: ", "http://localhost:3000")
          end,
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Chrome - attatch",
          console = "integratedTerminal",
          sourceMaps = true,
          webRoot = function()
            return "${workspaceFolder}" .. vim.fn.input("WEB ROOT: ")
          end,
          remoteRoot = function()
            return "${workspaceFolder}" .. vim.fn.input("REMOTE ROOT: ")
          end,
          url = function()
            return vim.fn.input("APP URL: ", "http://localhost:3000")
          end,
          port = function()
            return vim.fn.input("CHROME PORT: ", "9222")
          end,
        },
      }
    end

    dap.listeners.before.attach.dapui_config = function()
      setup_ui(function()
        dapui.open({ reset = true })
      end)
    end
    dap.listeners.before.launch.dapui_config = function()
      setup_ui(function()
        dapui.open({ reset = true })
      end)
    end
    dap.listeners.before.event_teminated.dapui_config = function()
      setup_ui(function()
        dapui.close()
      end)
    end

    dapui.setup()
  end
}

return M
