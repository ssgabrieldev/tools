return {
  "akinsho/bufferline.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      mode = "buffer",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = " ",
        },
        {
          filetype = "dapui_watches",
          text = "Debugger",
          text_align = "center",
          separator = " ",
        },
      },
      diagnostics = "nvim_lsp",
      indicator = {
        icon = '▎',
        style = 'icon',
      },
      sort_by = "insert_at_end"
    },
  },
  keys = {
    { "<leader>bp",     "<cmd>BufferLinePick<CR>",        desc = "Buffer line pick buffer" },
    { "<leader>bc",     "<cmd>BufferLinePickClose<CR>",   desc = "Buffer line close a buffer" },
    { "<leader>bo",     "<cmd>BufferLineCloseOthers<CR>", desc = "Buffer line close all buffer on the right" },
    { "<leader>bj",     "<cmd>BufferLineMovePrev<CR>",    desc = "Buffer line close all buffer on the left" },
    { "<leader>bk",     "<cmd>BufferLineMoveNext<CR>",    desc = "Buffer line close all buffer on the right" },
    { "<leader>b<s-j>", "<cmd>BufferLineCloseLeft<CR>",   desc = "Buffer line close all buffer on the left" },
    { "<leader>b<s-k>", "<cmd>BufferLineCloseRight<CR>",  desc = "Buffer line close all buffer on the right" },
    { "<leader>bs",     "<cmd>botright new<CR>",          desc = "New buffer split vert" },
    { "<leader>bv",     "<cmd>vsplit new<CR>",            desc = "New buffer split vert" },
    { "<s-tab>",        "<cmd>BufferLineCyclePrev<CR>",   desc = "Buffer line prev buffer" },
    { "<tab>",          "<cmd>BufferLineCycleNext<CR>",   desc = "Buffer line next buffer" },
  },
}
