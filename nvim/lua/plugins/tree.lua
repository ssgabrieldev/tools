local M = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  keys = {
    {
      "<leader>ee",
      function()
        local dapui_module = "dapui"
        if vim.g.debugger_is_open then
          require(dapui_module).close()
          vim.g.debugger_is_open = false
        end

        vim.cmd("NvimTreeToggle")
        vim.g.explore_is_open = not vim.g.explore_is_open
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
    }
  })
end

return M
