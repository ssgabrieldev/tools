return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        presets = {
            lsp_doc_border = vim.g.border_style,
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    }
}
