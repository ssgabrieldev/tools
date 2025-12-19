return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        presets = {
            lsp_doc_border = vim.g.border_style,
        },
        views = {
            cmdline_popup = {
                position = {
                    row = "0",
                    col = "50%",
                },
                size = {
                    width = "60",
                    height = "auto",
                },
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    }
}
