local M = {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>bp", "<cmd>BufferLinePick<CR>",       desc = "Buffer line pick buffer" },
    { "<leader>bc", "<cmd>BufferLinePickClose<CR>",  desc = "Buffer line close a buffer" },
    { "<leader>b<S-h>", "<cmd>BufferLineCloseLeft<CR>",  desc = "Buffer line close all buffer on the left" },
    { "<leader>b<S-l>", "<cmd>BufferLineCloseRight<CR>", desc = "Buffer line close all buffer on the right" },
    { "<leader>bh", "<cmd>BufferLineMovePrev<CR>",  desc = "Buffer line close all buffer on the left" },
    { "<leader>bl", "<cmd>BufferLineMoveNext<CR>", desc = "Buffer line close all buffer on the right" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Buffer line close all buffer on the right" },
    { "<leader>k",      "<cmd>BufferLineCycleNext<CR>",  desc = "Buffer line next buffer" },
    { "<leader>j",    "<cmd>BufferLineCyclePrev<CR>",  desc = "Buffer line prev buffer" }
  },
  lazy = false
}

function M.config()
  require("bufferline").setup({
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "dapui_watches",
          text = "Debugger",
          text_align = "center",
          separator = true,
        },
      },
      diagnostics = "nvim_lsp",
      indicator = {
        style = "none"
      }
    },
  })
end

return M
