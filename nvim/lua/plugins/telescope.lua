local got_to_propper_win = function()
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
end

local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    's1n7ax/nvim-window-picker',
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope-dap.nvim"
  },
  keys = {
    {
      "<leader>ff",
      function()
        got_to_propper_win()
        vim.cmd("Telescope find_files")
      end,
      desc = "Find file"
    },
    {
      "<leader>fw",
      function()
        got_to_propper_win()
        vim.cmd("Telescope live_grep")
      end,
      desc = "Find pattern"
    },
    {
      "<leader>fb",
      function()
        got_to_propper_win()
        vim.cmd("Telescope buffers")
      end,
      desc = "Find buffer"
    },
    {
      "<leader>fg",
      function()
        got_to_propper_win()
        vim.cmd("Telescope git_status")
      end,
      desc = "Find git change"
    },
    {
      "<leader>fk",
      function()
        got_to_propper_win()
        vim.cmd("Telescope keymaps")
      end,
      desc = "Find keymap"
    },
  }
}

function M.config()
  require("telescope").setup()
  require("telescope").load_extension("dap")
end

return M
