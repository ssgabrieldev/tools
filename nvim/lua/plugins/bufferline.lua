local nvim_tree_hl = vim.api.nvim_get_hl(0, { name = "NvimTreeNormal" })

return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            mode = "buffers",
            style_preset = "default",
            separator_style = "thin",
            indicator = {
                icon = '|',
                style = 'none',
            },
            themable = true,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = false,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "",
                    text_align = "center",
                    separator = true,
                    highlight = "NvimTreeNormal"
                },
                {
                    filetype = "codecompanion",
                    text = "",
                    text_align = "center",
                    separator = true,
                    highlight = "NvimTreeNormal"
                },
            },
            show_buffer_close_icons = true,
            show_close_icon = false,
            color_icons = true,
            enforce_regular_tabs = true,
            always_show_bufferline = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = { "close" },
            },
            get_element_icon = function(element)
                local devicons = require("nvim-web-devicons")
                local icon_text, icon_color = devicons.get_icon_by_filetype(element.filetype, { default = true })
                local current_bufpath = vim.api.nvim_buf_get_name(0)

                if current_bufpath ~= "" and element.path and element.path ~= "" then
                    local norm_current = vim.fs.normalize(current_bufpath)
                    local norm_element = vim.fs.normalize(element.path)

                    if norm_current == norm_element then
                        local hl_win_separator = vim.api.nvim_get_hl(0, { name = "WinSeparator" })
                        local hl_icon = vim.api.nvim_get_hl(0, { name = icon_color })

                        vim.api.nvim_set_hl(0, "BufferLine" .. icon_color .. "Selected", {
                            fg = hl_icon.fg,
                            bg = hl_win_separator.fg
                        })
                        return icon_text, icon_color
                    end
                end

                return icon_text, icon_color
            end
        },
    },
    keys = {
        { "<TAB>",          "<Cmd>BufferLineCycleNext<CR>",   desc = "Next Buffer" },
        { "<S-TAB>",        "<Cmd>BufferLineCyclePrev<CR>",   desc = "Previous Buffer" },
        { "<leader>bh",     "<Cmd>BufferLineMovePrev<CR>",    desc = "Move Buffer Left" },
        { "<leader>bl",     "<Cmd>BufferLineMoveNext<CR>",    desc = "Move Buffer Right" },
        { "<leader>bp",     "<Cmd>BufferLinePick<CR>",        desc = "Buffer picker" },
        { "<leader>bc",     "<Cmd>BufferLinePickClose<CR>",   desc = "Buffer picker" },
        { "<leader>b<s-h>", "<Cmd>BufferLineCloseLeft<CR>",   desc = "Buffer picker" },
        { "<leader>b<s-l>", "<Cmd>BufferLineCloseRight<CR>",  desc = "Buffer picker" },
        { "<leader>b<s-o>", "<Cmd>BufferLineCloseOthers<CR>", desc = "Buffer picker" },
    },
}
