local transparent = true

-- return {
--   "Tsuzat/NeoSolarized.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("NeoSolarized").setup({
--         transparent = true
--       })
--       vim.cmd [[ colorscheme NeoSolarized ]]
--     end
-- }

-- return {
--   "Mofiqul/adwaita.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.g.adwaita_darker = true
--     vim.g.adwaita_disable_cursorline = true
--     vim.g.adwaita_transparent = false
--     vim.cmd('colorscheme adwaita')
--   end
-- }

-- return {
--   'projekt0n/github-nvim-theme',
--   name = 'github-theme',
--   lazy = false,
--   priority = 1000,
--   opts = {
--     options = {
--       transparent = true
--     }
--   },
--   init = function ()
--     vim.cmd('colorscheme github_dark_default')
--   end
-- }

return {
  "navarasu/onedark.nvim",
  opts = {
    style = "darker",
    transparent = transparent,
    hide_ending_tildes = true,
    lualine = {
      transparent = transparent
    },
    diagnostics = {
      background = false
    },
    highlights = {
      NormalFloat = {fg = "$fg", bg = "transparent"},
      FloatBorder = {fg = "$fg", bg = "transparent"}
    }
  },
  init = function()
    require('onedark').load()
  end
}
