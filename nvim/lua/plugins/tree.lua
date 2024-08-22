local M = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>te", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" }
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

  -- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  --   pattern = { "*" },
  --   callback = function()
  --     if (vim.bo.buftype == "terminal") then
  --       vim.cmd("NvimTreeToggle")
  --       vim.cmd("NvimTreeToggle")
  --     end
  --   end
  -- })
end

return M
