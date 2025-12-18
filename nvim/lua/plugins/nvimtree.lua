return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    opts = {
        renderer = {
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "|",
                    edge = "|",
                    item = "|",
                    bottom = " ",
                    none = " ",
                },
            },
        },
        filters = {
            enable = false
        },
        actions = {
            open_file = {
                resize_window = false,
                window_picker = {
                    enable = false
                }
            }
        },
        update_focused_file = {
            enable = true
        }
    },
    keys = {
        {
            "<leader>ee",
            function()
                require("nvim-tree.api").tree.toggle()
            end,
            mode = {
                "n"
            },
            {
                desc = "Toggle NvimTree"
            }
        }
    },
}
