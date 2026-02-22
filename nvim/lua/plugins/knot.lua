return {
    enabled = true,
    -- "ssgabrieldev/knot.nvim",
    dir = "~/Documentos/opensource/knot.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
        vim.cmd("color knot")
    end,
}
