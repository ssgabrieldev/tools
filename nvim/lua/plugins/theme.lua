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
--   config = function()
--     require('github-theme').setup({
--       options = {
--         transparent = true
--       }
--     })
--
--     vim.cmd('colorscheme github_dark_default')
--   end,
-- }

return {
  "navarasu/onedark.nvim",
  opts = {
    style = "darker",
    transparent = true,
    lualine = {
      transparent = true
    }
  },
  init = function()
    require('onedark').load()
  end
}
