local lazygit_terminal = nil

local M = {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local hl_win_separator = vim.api.nvim_get_hl(0, { name = "WinSeparator", link = false })

        require("toggleterm").setup({
            persist_size = false,
            persist_mode = true,
            shade_terminals = false,
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
            winbar = {
                enabled = true,
                name_formatter = function(term)
                    return "  " .. (term.display_name or ("terminal " .. term.id)) .. " "
                end
            },
            highlights = {
                WinBarActive = {
                    guibg = hl_win_separator.fg
                }
            }
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
