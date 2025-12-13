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
                    text = "File Explorer",
                    text_align = "center",
                    separator = true,
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
        }
    },
    keys = {
        { "<TAB>",         "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
        { "<S-TAB>",       "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous Buffer" },
        { "<leader>bh", "<Cmd>BufferLineMovePrev<CR>",  desc = "Move Buffer Left" },
        { "<leader>bl", "<Cmd>BufferLineMoveNext<CR>",  desc = "Move Buffer Right" },
        { "<leader>bp",    "<Cmd>BufferLinePick<CR>",        desc = "Buffer picker" },
        { "<leader>bx",    "<Cmd>BufferLinePickClose<CR>",        desc = "Buffer picker" },
        { "<leader>b<s-h>",    "<Cmd>BufferLineCloseLeft<CR>",        desc = "Buffer picker" },
        { "<leader>b<s-l>",    "<Cmd>BufferLineCloseRight<CR>",        desc = "Buffer picker" },
        { "<leader>b<s-o>",    "<Cmd>BufferLineCloseOthers<CR>",        desc = "Buffer picker" },
    },
}
