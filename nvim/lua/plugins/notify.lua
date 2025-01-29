return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      background_colour = "#000000",
      on_open = function(win)
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_buf_set_option(buf, "filetype", "notify")
      end,
    })
    vim.notify = require("notify")
  end,
  keys = {
    {
      "<leader>cn",
      function()
        require("notify").dismiss()
      end
    }
  }
}
