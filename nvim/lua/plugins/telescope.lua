local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    's1n7ax/nvim-window-picker'
  },
  keys = {
    { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find file" },
    { "<leader>fw", "<CMD>Telescope live_grep<CR>",  desc = "Find pattern" },
    { "<leader>fb", "<CMD>Telescope buffers<CR>",    desc = "Find buffer" },
    { "<leader>fg", "<CMD>Telescope git_status<CR>", desc = "Find git change" },
    { "<leader>fk", "<CMD>Telescope keymaps<CR>",    desc = "Find keymap" },
  }
}

function M.config()
  require("telescope").setup({
    defaults = {
      mappings = {
        i = {
          ['<CR>'] = function(prompt_bufnr)
            local action_set = require('telescope.actions.set')
            local action_state = require('telescope.actions.state')

            local picker = action_state.get_current_picker(prompt_bufnr)
            picker.get_selection_window = function(picker, entry)
              if
                  string.match(vim.bo.filetype, "dap")
                  or vim.bo.filetype == "toggleterm"
              then
                for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                  local current_bufnr = vim.bo[bufnr]
                  if vim.fn.bufwinid(bufnr) ~= -1 then
                    if
                      not string.match(current_bufnr.filetype, "dap")
                      and current_bufnr.filetype ~= "toggleterm"
                      and current_bufnr.filetype ~= "NvimTree"
                    then
                      vim.api.nvim_set_current_win(vim.fn.bufwinid(bufnr))
                    end
                  end
                end
              end

              local picked_window_id = vim.api.nvim_get_current_win()
              picker.get_selection_window = nil
              return picked_window_id
            end

            return action_set.edit(prompt_bufnr, 'edit')
          end,
        },
      }
    }
  })
end

return M
