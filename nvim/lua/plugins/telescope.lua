local utils_buffers = require("plugins.utils.buffers")
local go_to_buf_file = utils_buffers.go_to_buf_file

local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    's1n7ax/nvim-window-picker',
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope-dap.nvim",
    'akinsho/toggleterm.nvim',
  },
  keys = {
    {
      "<leader>ff",
      function()
        go_to_buf_file()
        vim.cmd("Telescope find_files")
      end,
      desc = "Find file"
    },
    {
      "<leader>fw",
      function()
        go_to_buf_file()
        vim.cmd("Telescope live_grep")
      end,
      desc = "Find pattern"
    },
    {
      "<leader>fb",
      function()
        go_to_buf_file()
        vim.cmd("Telescope buffers")
      end,
      desc = "Find buffer"
    },
    {
      "<leader>fg",
      function()
        go_to_buf_file()
        vim.cmd("Telescope git_status")
      end,
      desc = "Find git change"
    },
    {
      "<leader>fk",
      function()
        go_to_buf_file()
        vim.cmd("Telescope keymaps")
      end,
      desc = "Find keymap"
    }
  }
}

function M.config()
  require("telescope").setup({
    defaults = {
      preview = true
    }
  })
end

return M
