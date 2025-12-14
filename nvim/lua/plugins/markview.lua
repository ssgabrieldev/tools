-- local presets = require("markview.presets").headings;

return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
        preview = {
            filetypes = { "markdown", "codecompanion" },
            ignore_buftypes = {},
        },
        markdown = {
            headings = {
                shift_width = 0
            },
            code_blocks = {
                wrap = false,
                style = "simple"
            }
        }
    },
}
