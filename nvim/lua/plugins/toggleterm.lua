local lazygit_terminal = nil

local M = {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        persist_size = false,
        persist_mode = true,
        shade_terminals = true,
        shading_factor = -45,
        float_opts = {
            border = vim.g.border_style,
            title_pos = "center",
            winblend = 3,
        },
        winbar = {
            enabled = true,
            name_formatter = function(term)
                return " " .. (term.display_name or ("terminal " .. term.id))
            end
        }
    },
    keys = {
        {
            '<leader>tt',
            function()
                vim.cmd(vim.v.count .. "ToggleTerm direction=horizontal")
            end,
            mode = { "n", "t" },
            { desc = 'Toggle terminal' }
        },
        {
            '<leader>tf',
            function()
                vim.cmd(vim.v.count .. "ToggleTerm direction=float")
            end,
            mode = { "n", "t" },
            { desc = 'Toggle terminal' }
        },
        {
            "<leader>tg",
            function()
                if not lazygit_terminal then
                    local Terminal = require('toggleterm.terminal').Terminal
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
