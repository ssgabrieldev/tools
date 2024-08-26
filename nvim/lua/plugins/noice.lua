local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  keys = {
    {
      '<leader><C-l>',
      function()
        vim.cmd("NoiceDismiss")
      end,
      mode = { "n", "t" },
      { desc = 'Toggle terminal horizontal' }
    },
  },
  config = function()
    require("noice").setup({
      presets = {
        lsp_doc_border = {
          views = {
            hover = {
              border = {
                style = "single"
              }
            }
          }
        }
      },
      lsp = {
        progress = {
          enable = true,
          view = "mini",
        },
      },
      popupmenu = {
        backend = "cmp"
      },
    })
  end
}

return M
