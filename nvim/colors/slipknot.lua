local lush = require("lush")
local theme = require("themes.slipknot")

vim.opt.background = 'dark'
vim.g.colors_name = 'slipknot'
package.loaded['themes.slipknot'] = nil

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.schedule(function()
      -- Registra a highlight group no Neovim (global)
      vim.api.nvim_set_hl(0, "TerminalBuffer", {
        fg = theme.TerminalBuffer.fg.hex,
        bg = theme.TerminalBuffer.bg.hex,
      })

      -- Aplica o highlight APENAS na janela atual, substituindo "Normal"
      vim.api.nvim_set_option_value("winhighlight", "Normal:TerminalBuffer", { scope = "local" })
    end)
  end,
})

lush(theme)
