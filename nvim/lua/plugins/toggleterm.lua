local lazygit_terminal = nil

local M = {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local nvim_tree_normal_hl = vim.api.nvim_get_hl(0, { name = "NvimTreeNormal" })

        require("toggleterm").setup({
            persist_size = false,
            persist_mode = true,
            shade_terminals = true,
            shading_factor = -45,
            float_opts = {
                border = "none",
                title_pos = "center",
                winblend = 0,
                width = vim.o.columns,
                height = vim.o.lines - 2,
            },
            winbar = {
                enabled = true,
                name_formatter = function(term)
                    return " " .. (term.display_name or ("terminal " .. term.id))
                end
            },
            highlights = {
                Normal = {
                    link = "NvimTreeNormal"
                },
                WinBar = {
                    link = "NvimTreeNormal"
                },
                WinBarNC = {
                    link = "NvimTreeNormal"
                },
                WinBarActive = {
                    guibg = nvim_tree_normal_hl.bg,
                    gui = "bold"
                },
                WinBarInactive = {
                    link = "NvimTreeNormal"
                },
                CursorLine = {
                    link = "NvimTreeNormal"
                }
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
