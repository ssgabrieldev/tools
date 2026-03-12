local border = vim.g.border_style

return {
    "williamboman/mason.nvim",
    event = "BufEnter",
    opts = {
        ui = {
            border = border
        }
    }
}
