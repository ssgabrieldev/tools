local lazygit_terminal = nil

local M = {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            persist_size = false,
            persist_mode = true,
            shade_terminals = false,
            winbar = { enabled = false },
            float_opts = {
                border = "none",
                title_pos = "center",
                winblend = 0,
                width = function()
                    return vim.o.columns
                end,
                height = function()
                    return vim.o.lines - 2
                end,
            },
        })
    end,
    keys = {
        {
            "<leader>tt",
            function()
                vim.cmd(vim.v.count .. "ToggleTerm direction=horizontal")
            end,
            mode = { "n", "t" },
            { desc = "Toggle terminal" }
        },
        {
            "<leader>tf",
            function()
                vim.cmd(vim.v.count .. "ToggleTerm direction=float")
            end,
            mode = { "n", "t" },
            { desc = "Toggle terminal" }
        },
        {
            "<leader>tg",
            function()
                if not lazygit_terminal then
                    local Terminal = require("toggleterm.terminal").Terminal
                    lazygit_terminal = Terminal:new({
                        cmd = "lg",
                        direction = "float",
                        hidden = true,
                        count = 1001,
                        on_exit = function()
                            lazygit_terminal = nil
                        end
                    })
                end
                lazygit_terminal:toggle();
            end,
            mode = { "n", "t" },
            { desc = "Lazysql" }
        },
    }
}

return M
