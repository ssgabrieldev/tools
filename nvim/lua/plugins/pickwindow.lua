return {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  keys = {
    {
      "<leader>wp",
      function()
        local win_id = require("window-picker").pick_window({
          hint = 'floating-big-letter'
        })
        vim.api.nvim_set_current_win(win_id)
      end,
      mode = { "n" },
      desc = "Pick window"
    }
  },
  config = function()
    require('window-picker').setup({
      filter_rules = {
        autoselect_one = false,
        include_current_win = true,
        include_unfocusable_windows = true,
        bo = {
          filetype = {},
          buftype = {},
        },
        wo = {},
        file_path_contains = {},
        file_name_contains = {},
      },
    })
  end,
}
