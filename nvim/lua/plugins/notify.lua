return {
  "rcarriga/nvim-notify",
  opts = {
    background_colour = "#000000",
    timeout = 1000,
    stages = "slide",
    on_open = function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.api.nvim_buf_set_option(buf, "filetype", "notify")
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
  },
  init = function()
    vim.notify = require("notify")
  end,
  keys = {
    {
      "<leader>nc",
      function()
        require("notify").dismiss()
      end
    },
  }
}
