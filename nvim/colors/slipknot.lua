local lush = require("lush")
local theme = require("themes.slipknot")

vim.opt.background = 'dark'
vim.g.colors_name = 'slipknot'
package.loaded['themes.slipknot'] = nil

vim.api.nvim_create_autocmd("WinNew", {
  callback = function()
    vim.defer_fn(function()
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_buf_get_option(buf, "filetype")

      if ft == "toggleterm" then
        vim.api.nvim_set_hl(0, "TerminalBuffer", { fg = theme.theme.TerminalBuffer.fg.hex, bg = theme.theme.TerminalBuffer.bg.hex, })

        vim.api.nvim_set_option_value("winhighlight", "Normal:TerminalBuffer", { scope = "local" })
      end
    end, 10)
  end,
})

-- vim.api.nvim_create_autocmd({"WinEnter"}, {
--   callback = function(args)
--     local win_id = vim.api.nvim_get_current_win()
--     local config = vim.api.nvim_win_get_config(win_id)
--
--     if config.relative ~= "" then
--       return
--     end
--
--     local current_buf_id = vim.api.nvim_win_get_buf(win_id)
--
--     local file_type = vim.bo[current_buf_id].filetype
--
--     if file_type == "toggleterm" then
--     end
--   end,
-- })

lush(theme.theme)
