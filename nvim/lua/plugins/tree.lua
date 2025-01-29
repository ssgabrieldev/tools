local M = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "s1n7ax/nvim-window-picker",
    "rcarriga/nvim-notify",
  },
  lazy = false,
  keys = {
    {
      "<leader>ee",
      function()
        vim.cmd("NvimTreeToggle")
      end,
      desc = "Explorer"
    }
  }
}

function M.config()
  require("nvim-tree").setup({
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
            require("notify").dismiss()
            return require("window-picker").pick_window()
          end,
        },
      },
    },
  })
end

return M
