local ui_utils = require("plugins.utils.ui")

return {
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      transparent_background = ui_utils.get_transparency()
    },
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
