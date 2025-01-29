return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      -- progress = {
      --   enabled = true, -- Ativa as mensagens de progresso do LSP
      --   format = {
      --     { "{spinner} ",                  hl_group = "NoiceLspProgressSpinner" },
      --     { "{data.progress.title} ",      hl_group = "NoiceLspProgressTitle" },
      --     { "{data.progress.percentage}%", hl_group = "NoiceLspProgressPercentage" },
      --     { "{data.progress.message}",     hl_group = "NoiceLspProgressMessage" },
      --   },
      --   format_done = "✔ {data.progress.title}",
      -- },
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
