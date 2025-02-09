local M = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "s1n7ax/nvim-window-picker",
  },
  opts = {
    reload_on_bufenter = true,
    update_focused_file = {
      enable = true,
    },
    renderer = {
      indent_markers = {
        enable = true,
        icons = {
          corner = "|",
          edge = "|",
          item = "|",
          bottom = "|",
          none = " ",
        },
      },
    },
    diagnostics = {
      enable = true
    },
    git = {
      ignore = false
    },
    actions = {
      open_file = {
        window_picker = {
          enable = true,
          picker = function()
            return require("window-picker").pick_window({
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
          end,
        },
      },
    },
  },
  keys = {
    {
      "<leader>ee",
      function()
        require("nvim-tree.api").tree.toggle()
      end,
      mode = {"n", "t"},
      desc = "Explorer toggle"
    },
    {
      "<leader>ef",
      function()
        require("nvim-tree.api").tree.focus()
      end,
      mode = {"n", "t"},
      desc = "Explorer focus"
    },
    {
      "<leader>er",
      function()
        require("nvim-tree.api").tree.reload()
      end,
      mode = {"n", "t"},
      desc = "Explorer reload"
    },
  }
}

return M
