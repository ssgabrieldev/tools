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
  end
}
