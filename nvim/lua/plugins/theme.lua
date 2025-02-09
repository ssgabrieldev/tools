local transparent = true

return {
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      tweak_background = {
        normal = transparent and "none" or transparent and "none" or "default",
        telescope = transparent and "none" or "default",
        menu = transparent and "none" or "default",
        popup = transparent and "none" or "default",
      },
    }
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      transparent_background = transparent
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
        bg = transparent,
        float = transparent
      }
    }
  },
  {
    "Tsuzat/NeoSolarized.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = transparent
    },
  },
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.adwaita_darker = true
      vim.g.adwaita_disable_cursorline = true
      vim.g.adwaita_transparent = transparent
    end
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = transparent
      }
    }
  },
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "deep",
      transparent = transparent,
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
