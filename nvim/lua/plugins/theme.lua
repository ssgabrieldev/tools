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
        popup = ui_utils.get_transparency() and "none" or "default",
      },
    }
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      transparent_background = ui_utils.get_transparency()
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
        bg = ui_utils.get_transparency(),
        float = ui_utils.get_transparency()
      }
    }
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = ui_utils.get_transparency()
      }
    }
  },
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "deep",
      transparent = ui_utils.get_transparency(),
      ending_tildes = false,
      lualine = {
        transparent = false
      },
      diagnostics = {
        background = false
      },
      highlights = {
        NormalFloat = { fg = "$fg", bg = "transparent" },
        FloatBorder = { fg = "$fg", bg = "transparent" },
      }
    }
  }
}
