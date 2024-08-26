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
  config = function ()
    require("noice").setup({
      presets = {
        lsp_doc_border = true
      }
    })
  end
}

return M
