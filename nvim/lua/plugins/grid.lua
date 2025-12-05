local vim = vim

return {
    "ssgabrieldev/grid.nvim",
    enabled = true,
    lazy = false,
    dependecies = {
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        layout = {
            {
                type = "col",
                children = {
                    {
                        type = "row",
                        width = 35,
                        buffer_match = function(buffer)
                            local filetypes = { "NvimTree" }

                            return vim.tbl_contains(filetypes, buffer:filetype())
                        end,
                    },
                    {
                        type = "row",
                        width = 35,
                        height = 10,
                        buffer_match = function(buffer)
                            local filetype = buffer:filetype()
                            local filetypes = {
                                "Outline"
                            }

                            return vim.tbl_contains(filetypes, filetype)
                        end,
                    }
                }
            },
            {
                type = "col",
                children = {
                    {
                        type = "row",
                        buffer_match = function(buffer)
                            local node = buffer:get_node()
                            local match = not node
                                and (
                                    buffer:is_listed()
                                    or buffer:filetype() ~= ""
                                )

                            if match then
                                return true
                            end

                            return false
                        end,
                    },
                    {
                        type = "row",
                        height = 15,
                        buffer_match = function(buffer)
                            local filetype = vim.bo[buffer.id].filetype
                            local filetypes = {
                                "codecompanion",
                                "terminal",
                                "toggleterm",
                                "dap-view://main",
                                "dap-view-term",
                                "dap-view",
                                "dap-repl",
                                "qf"
                            }

                            return vim.tbl_contains(filetypes, filetype)
                        end,
                    },
                },
            }
        }
    }
}
