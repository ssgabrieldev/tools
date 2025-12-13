return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
      presets = {
        lsp_doc_border = vim.g.border_style, -- add a border to hover docs and signature help
      },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    }
}
