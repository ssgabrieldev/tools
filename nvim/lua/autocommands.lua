local function find_in_list(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local ft = args.match
        local default_hl = ""
        local ignore_fts = {
            "toggleterm"
        }
        local fts = {
            "codecompanion",
            "dap-repl",
            "dap-view"
        }

        if find_in_list(ignore_fts, ft) then
            return
        end

        if find_in_list(fts, ft) then
            default_hl = "Normal:NvimTreeNormal,EndOfBuffer:NvimTreeEndOfBuffer"

            if ft ~= "codecompanion" and ft ~= "toggleterm" then
                local nvim_tree_nromal_hl = vim.api.nvim_get_hl(0, { name = "NvimTreeNormal" })
                default_hl = default_hl .. ",NvimDapViewTab:NvimTreeNormal,WinBar:NvimTreeNormal"

                vim.api.nvim_set_hl(0, "NvimDapViewTabSelected", {
                    bold = true,
                    bg = nvim_tree_nromal_hl.bg
                })
            end
        end

        if vim.bo[args.buf].buftype == "" then
            default_hl = ""
        end

        vim.wo.winhighlight = default_hl
    end,
})
