local window_picker_utils = require("plugins.utils.window-picker")

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
      enable = true,
      icons = {
        hint = "󰌶",
        info = "󰋽",
        warning = "",
        error = "",
      },
    },
    git = {
      ignore = false
    },
    actions = {
      open_file = {
        window_picker = {
          enable = true,
          picker = function()
            return window_picker_utils.pick_window_to_open_buf(
              {
                "toggleterm",
                "dap-view",
                "notify",
                "NvimTree"
              },
              {
                "NvimTree"
              }
            )
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
      mode = { "i", "n", "t" },
      desc = "Explorer toggle"
    },
    {
      "<leader>ef",
      function()
        require("nvim-tree.api").tree.focus()
      end,
      mode = { "i", "n", "t" },
      desc = "Explorer focus"
    },
    {
      "<leader>er",
      function()
        require("nvim-tree.api").tree.reload()
      end,
      mode = { "i", "n", "t" },
      desc = "Explorer reload"
    },
  }
}

return M
