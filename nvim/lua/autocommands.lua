local dark_ns = vim.api.nvim_create_namespace("DarkWindowStyles")
local nvim_tree_hl = vim.api.nvim_get_hl(0, { name = "NvimTreeNormal" })

vim.api.nvim_set_hl(dark_ns, "Normal", { link = "NvimTreeNormal" })
vim.api.nvim_set_hl(dark_ns, "CursorLine", { link = "Normal" })
vim.api.nvim_set_hl(dark_ns, "EndOfBuffer", { link = "NvimTreeEndOfBuffer" })
vim.api.nvim_set_hl(dark_ns, "NvimDapViewTab", { link = "NvimTreeNormal" })
vim.api.nvim_set_hl(dark_ns, "WinBar", { link = "NvimTreeNormal" })
vim.api.nvim_set_hl(dark_ns, "WinBarNC", { link = "NvimTreeNormal" })
vim.api.nvim_set_hl(dark_ns, "NvimDapViewTabSelected", {
    bold = true,
    bg = nvim_tree_hl.bg
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "codecompanion", "dap-repl", "dap-view", "qf" },
    callback = function(args)
        vim.api.nvim_win_set_hl_ns(0, dark_ns)
    end,
})
