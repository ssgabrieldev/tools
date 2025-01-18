local utils_vim = require("plugins.utils.vim")

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
    "nvim-telescope/telescope-dap.nvim",
    'akinsho/toggleterm.nvim',
  },
  keys = {
    {
      "<leader>dd",
      function()
        vim.cmd("DapToggleBreakpoint")
      end,
      desc = "Debugger toggle breakpoint"
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
      "<leader>dl",
      function()
        require("dapui").float_element()
        require("dapui").float_element()
      end,
      desc = "Debugger list frames"
    }  },
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
            table.insert(args, arg)

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

    dapui.setup()
  end
}

return M
