local lush = require("lush")
local theme = require("themes.slipknot")

vim.opt.background = 'dark'
vim.g.colors_name = 'slipknot'
package.loaded['themes.slipknot'] = nil

lush(theme.theme)
