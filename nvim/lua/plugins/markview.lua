-- local presets = require("markview.presets").headings;

return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
        preview = {
            filetypes = { "markdown", "codecompanion" },
            ignore_buftypes = { "nofile" }
        },
        markdown = {
            headings = {
                shift_width = 0,
                sign = false,
                heading_1 = {
                    sign = "",
                },
                heading_2 = {
                    sign = "",
                },
                heading_3 = {
                    sign = "",
                },
                heading_4 = {
                    sign = "",
                },
                heading_5 = {
                    sign = "",
                }
            },
            code_blocks = {
                sign = false,
                style = "block",
                label_direction = "right"
            }
        }
    },
}
