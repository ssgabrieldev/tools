return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        fix_win_height = true,
        left = {
            {
                ft = "NvimTree",
                wo = {
                    winfixbuf = false
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
                    winbar = false
                }
            },
            {
                ft = "dap-view://main",
                wo = {
                    winbar = false
                }
            },
            {
                ft = "dap-view-term",
                wo = {
                    winbar = false
                }
            },
            {
                ft = "dap-view",
                wo = {
                    winbar = false
                }
            },
            {
                ft = "dap-repl",
                wo = {
                    winbar = false
                }
            },
            "qf",
            "help",
        },
        right = { "codecompanion" },
        top = {},
        options = {
            left = { size = 35 },
            bottom = {
                size = 15,
                wo = {
                    winhighlight = "Normal:EdgyNormal",
                }
            },
            right = { size = 35 },
            top = { size = 15 },
        },
        wo = {
            winfixbuf = false,
            winfixwidth = false,
            winfixheight = false,
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
