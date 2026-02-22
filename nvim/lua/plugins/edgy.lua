return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        fix_win_height = false,
        left = {
            {
                ft = "NvimTree",
                wo = {
                    winfixbuf = false
                }
            }
        },
        bottom = {
            "terminal", "dap-view://main", "dap-view-term", "dap-view", "dap-repl", "qf", "help",
            {
                ft = "toggleterm",
                filter = function(buf, win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
        },
        right = { "codecompanion" },
        top = {},
        options = {
            left = { size = 35 },
            bottom = { size = 15 },
            right = { size = 35 },
            top = { size = 15 },
        },
        wo = {
            winfixbuf = true,
            winfixwidth = false,
            winfixheight = false,
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
