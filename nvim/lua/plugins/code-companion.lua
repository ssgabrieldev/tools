return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "github/copilot.vim",
        "nvim-lua/plenary.nvim",
    },
    opts = {
        strategies = {
            chat = {
                adapter = "copilot",
            },
            inline = {
                adapter = "copilot",
            },
            cmd = {
                adapter = "copilot",
            }
        }
    },
    keys = {
        { "<leader>cc", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions" },
    }
}
