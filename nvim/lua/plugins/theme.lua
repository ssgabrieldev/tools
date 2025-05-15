local ui_utils = require("plugins.utils.ui")

return {
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      tweak_background = {
        normal = ui_utils.get_transparency() and "none" or "default",
        telescope = ui_utils.get_transparency() and "none" or "default",
        menu = ui_utils.get_transparency() and "none" or "default",
        popup = "none"
      },
      disable_plugin = {
        bufferline = true
      }
    }
  },
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("black-metal").setup({
        transparent = ui_utils.get_transparency(),
        favor_treesitter_hl = true
      })
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = ui_utils.get_transparency()
      }
    }
  }
}
