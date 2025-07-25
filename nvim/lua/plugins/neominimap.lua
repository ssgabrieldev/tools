local vim = vim

return {
  "Isrothy/neominimap.nvim",
  version = "v3.x.x",
  lazy = false,
  keys = {
    { "<leader>mm",  "<cmd>Neominimap Toggle<cr>",      desc = "NeoMiniMap toggle" },
    { "<leader>mf",  "<cmd>Neominimap ToggleFocus<cr>",      desc = "NeoMiniMap toggle focus" },
  },
  init = function()
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36 -- Set a large value

    vim.g.neominimap = {
      auto_enable = true,
    }
  end,
}
