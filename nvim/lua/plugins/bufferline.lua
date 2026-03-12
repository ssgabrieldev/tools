local nvim_tree_hl = vim.api.nvim_get_hl(0, { name = "NvimTreeNormal" })

local get_element_icon = function(element)
    local devicons = require("nvim-web-devicons")
    local icon_text, icon_color = devicons.get_icon_by_filetype(element.filetype, { default = true })
    local hl_icon_prefix = "BufferLine" .. icon_color
    local hl_icon = vim.api.nvim_get_hl(0, {
        name = icon_color
    })
    local hl_bufferline_background = vim.api.nvim_get_hl(0, {
        name = "BufferLineBackground"
    })
    local hl_bufferline_buffer_selected = vim.api.nvim_get_hl(0, {
        name = "BufferLineBufferSelected"
    })

    vim.api.nvim_set_hl(0, hl_icon_prefix, {
        fg = hl_icon.fg,
        bg = hl_bufferline_background.bg
    })
    vim.api.nvim_set_hl(0, hl_icon_prefix .. "Visible", {
        fg = hl_icon.fg,
        bg = hl_bufferline_background.bg,
        bold = true
    })
    vim.api.nvim_set_hl(0, hl_icon_prefix .. "Inactive", {
        fg = hl_icon.fg,
        bg = hl_bufferline_background.bg,
    })
    vim.api.nvim_set_hl(0, hl_icon_prefix .. "Selected", {
        fg = hl_icon.fg,
        bg = hl_bufferline_buffer_selected.bg,
        bold = true
    })

    return icon_text, icon_color
end

return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            mode = "buffers",
            separator_style = { "", "" },
            indicator = { icon = "", style = "none" },
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
            get_element_icon = get_element_icon
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
