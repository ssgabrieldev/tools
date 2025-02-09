local transparent = true

return {
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
      -- vim.cmd('colorscheme adwaita')
    end
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
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
        transparent = transparent
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
