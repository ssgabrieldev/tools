return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufEnter",
  build = function()
    local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
    ts_update()
  end,
  opts = {
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    ident = {
      enable = true,
    },
    fold = {
      enable = true
    }
  },
  init = function()
    vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
    vim.opt.foldlevel = 99
  end
}
