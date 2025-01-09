local M = {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    build = function()
        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
        ts_update()
    end,
}

function M.config()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
            use_languagetree = true,
        },
        ident = {
            enable = true,
        },
    })
end

return M
