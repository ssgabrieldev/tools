return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      hover = {
        opts = {
          border = vim.g.border_style,
          max_width = 80,
          max_height = 40
        }
      },
      signature = {
        opts = {
          border = vim.g.border_style
        }
      },
    }
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  }
}
