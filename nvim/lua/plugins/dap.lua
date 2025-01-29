local utils_vim = require("plugins.utils.vim")
local float_opts = {
  enter = true,
  position = "center",
  border = vim.g.border_style
}

local ask_webroot = function()
  return "${workspaceFolder}" .. utils_vim.input("WEB ROOT: ")
end

local ask_remoteroot = function()
  return "${workspaceFolder}" .. utils_vim.input("REMOTE ROOT: ")
end

local ask_url = function()
  return utils_vim.input("APP URL: ", "http://localhost:3000")
end

local ask_port = function()
  return utils_vim.input("BROWSER PORT: ", "9222")
end

local ask_custom_command = function()
  local terminal_module = "toggleterm"

  if not package.loaded[terminal_module] then
    return
  end

  require("dapui").close()

  local command = utils_vim.input("COMMAND TO RUN: ")

  if command ~= "" then
    local term = require(terminal_module .. ".terminal").Terminal:new({
      cmd = command,
      hidden = false,
      direction = "float"
    })
    term:toggle()
  end
end

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

local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-dap.nvim",
    'akinsho/toggleterm.nvim',
  },
  keys = {
    {
      "<leader>db",
      function()
        vim.cmd("DapToggleBreakpoint")
      end,
      desc = "Debugger toggle breakpoint"
    },
    {
      "<leader>de",
      function()
        vim.cmd("DapTerminate")
      end,
      desc = "Debugger terminate"
    },
    {
      "<leader>dr",
      function()
        got_to_propper_win()
        vim.cmd("DapContinue")
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
        require("dapui").eval()
        require("dapui").eval()
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
          runtimeArgs = function()
            local args = {}
            local arg = utils_vim.input(
              "File to run (default: " .. vim.fn.expand('%') .. "): ",
              ""
            )

            if arg == "" then
              arg = "${file}"
            end

            table.insert(args, arg)

            return args
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
          webRoot = ask_webroot,
          remoteRoot = ask_remoteroot,
          url = function()
            ask_custom_command()

            return ask_url()
          end,
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Chrome - attatch",
          console = "integratedTerminal",
          sourceMaps = true,
          webRoot = ask_webroot,
          remoteRoot = ask_remoteroot,
          url = function()
            ask_custom_command()

            return ask_url()
          end,
          port = ask_port
        },
      }
    end

    dapui.setup({
      expand_lines = false
    })

    dap.listeners.before.event_terminated.dapui_config = function()
      require("notify")("Debugger teminated", "info")
    end
    dap.listeners.before.event_exited.dapui_config = function()
      require("notify")("Debugger exited", "error")
    end
  end
}

return M
