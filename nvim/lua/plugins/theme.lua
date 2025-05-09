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
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = true,
      transparent = ui_utils.get_transparency(),
      dimInactive = false,
      overrides = function(colors)
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          TelescopePromptNormal = { bg = "none" },
          TelescopePromptBorder = { bg = "none" },
          TelescopeResultsNormal = { bg = "none" },
          TelescopeResultsBorder = { bg = "none" },
          TelescopePreviewNormal = { bg = "none" },
          TelescopePreviewBorder = { bg = "none" },
        }
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
              float = {
                bg = "none",
                bg_border = "none"
              }
            }
          }
        }
      }
    }
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "deep",
      transparent = ui_utils.get_transparency(),
      lualine = {
        transparent = ui_utils.get_transparency(),
      },
      diagnostics = {
        background = false,
      },
      highlights = {
        FloatBorder = { bg = "transparent" },
        NormalFloat = { bg = "transparent" },
      }
    },
  },
  {
    'bettervim/yugen.nvim',
    lazy = false,
    priority = 1000,
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
  }
}
