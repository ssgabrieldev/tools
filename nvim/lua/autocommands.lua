local dark_ns = vim.api.nvim_create_namespace("DarkWindowStyles")

vim.api.nvim_set_hl(dark_ns, "Normal", { link = "NvimTreeNormal" })
vim.api.nvim_set_hl(dark_ns, "CursorLine", { link = "Normal" })
vim.api.nvim_set_hl(dark_ns, "EndOfBuffer", { link = "NvimTreeEndOfBuffer" })
vim.api.nvim_set_hl(dark_ns, "WinBar", { link = "NvimTreeNormal" })
vim.api.nvim_set_hl(dark_ns, "WinBarNC", { link = "NvimTreeNormal" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "codecompanion", "dap-repl", "dap-view", "qf" },
    callback = function(args)
        vim.api.nvim_win_set_hl_ns(0, dark_ns)
    end,
})
