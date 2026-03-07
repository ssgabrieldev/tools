local lazygit_terminal = nil

local get_terminal_by_buffer = function(bufnr)
    local toggle_terminal = require("toggleterm.terminal")
    local terminals = toggle_terminal.get_all()

    for _, terminal in ipairs(terminals) do
        if terminal.bufnr == bufnr then
            return terminal
        end
    end
end

local get_terminal_by_id = function(id)
    local toggle_terminal = require("toggleterm.terminal")
    local terminals = toggle_terminal.get_all()

    for _, terminal in ipairs(terminals) do
        if terminal.id == id then
            return terminal
        end
    end
end

return {
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
                local toggle_terminal = require("toggleterm.terminal")
                local current_terminal = get_terminal_by_buffer(vim.api.nvim_get_current_buf())
                local current_win = vim.api.nvim_get_current_win()

                if current_terminal then
                    if vim.v.count == 0 then
                        vim.cmd("ToggleTerm")
                    else
                        local terminal = get_terminal_by_id(vim.v.count)

                        if terminal then
                            if terminal.id == current_terminal.id then
                                current_terminal:toggle()

                                return
                            end

                            if terminal:is_open() then
                                return
                            end

                            vim.wo.winfixbuf = false
                            vim.api.nvim_win_set_buf(0, terminal.bufnr)
                            terminal.window = current_win
                            terminal:__resurrect()
                            vim.wo.winfixbuf = true
                        else
                            local new_terminal = toggle_terminal.Terminal:new({
                                count = vim.v.count,
                                id = vim.v.count,
                            })

                            new_terminal:spawn()
                            vim.wo.winfixbuf = false
                            vim.api.nvim_win_set_buf(0, new_terminal.bufnr)
                            new_terminal.window = current_win
                            vim.wo.winbar = "%{%v:lua.custom_toggleterm_bar()%}"
                            new_terminal:__resurrect()
                            vim.wo.winfixbuf = true
                        end
                    end
                else
                    if vim.v.count == 0 then
                        vim.cmd("ToggleTerm direction=horizontal")
                    else
                        vim.cmd(vim.v.count .. "ToggleTerm direction=horizontal")
                    end
                end
            end,
            mode = { "n", "t" },
            { desc = "Toggle terminal", silent = true }
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
