return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        fix_win_height = true,
        left = {
            {
                ft = "NvimTree",
                wo = {
                    winfixbuf = false,
                    winbar = false
                }
            }
        },
        bottom = {
            {
                ft = "toggleterm",
                filter = function(buf, win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
                wo = {
                    winfixbuf = true,
                    winbar = false
                }
            },
            {
                ft = "dap-view://main",
                wo = {
                    winfixbuf = true,
                    winbar = false
                }
            },
            {
                ft = "dap-view-term",
                wo = {
                    winfixbuf = true,
                    winbar = false
                }
            },
            {
                ft = "dap-view",
                wo = {
                    winfixbuf = true,
                    winbar = false
                }
            },
            {
                ft = "dap-repl",
                wo = {
                    winfixbuf = true,
                    winbar = false
                }
            },
            {
                ft = "qf",
                wo = {
                    winfixbuf = true
                }
            },
            {
                ft = "help",
                wo = {
                    winfixbuf = true
                }
            },
        },
        right = {
            {
                ft = "codecompanion",
                wo = {
                    winfixbuf = true
                }
            },
        },
        top = {},
        options = {
            left = { size = 35 },
            bottom = { size = 15 },
            right = { size = 35 },
            top = { size = 15 },
        },
        animate = {
            enabled = false
        },
        keys = {
            ["<a-l>"] = function(win)
                win:resize("width", 2)
            end,
            ["<a-h>"] = function(win)
                win:resize("width", -2)
            end,
            ["<a-k>"] = function(win)
                win:resize("height", 2)
            end,
            ["<a-j>"] = function(win)
                win:resize("height", -2)
            end,
        }
    },
}
