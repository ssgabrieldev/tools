local vim = vim

local function get_toggleterm_winbar()
    local toggle_terminal = require("toggleterm.terminal")
    local bufs = vim.api.nvim_list_bufs()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_win = vim.g.actual_curwin
    local items = {}

    for _, buf in ipairs(bufs) do
        local id = vim.b[buf].toggle_number

        if id ~= nil then
            local term = toggle_terminal.get(id)

            if term then
                -- print(type(current_win) .. " " .. type(term.window))

                local name = "   " .. (term.name or term.count) .. "  "
                local hl_active = "%#BufferLineBufferSelected#"
                local hl_inactive = "%#BufferLineBackground#"
                local hl = buf == current_buf and hl_active or hl_inactive
                hl = term.window ~= tonumber(current_win) and hl_inactive or hl

                table.insert(items, hl .. name)
            end
        end
    end

    local winbar = "%*" .. table.concat(items, "") .. "%#BufferLineFill#"

    return winbar
end

_G.custom_toggleterm_bar = get_toggleterm_winbar

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
                    winbar = "%{%v:lua.custom_toggleterm_bar()%}",
                },
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
            right = { size = 40 },
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
