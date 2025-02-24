return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  lazy = false,
  keys = {
    {
      "<leader>wp",
      function()
        local win_id = require("window-picker").pick_window()

        if not win_id then
          return
        end

        vim.api.nvim_set_current_win(win_id)
      end,
      mode = { "n", "t", "i" },
      desc = "Pick window"
    },
    {
      "<leader>wc",
      function()
        local win_id = require("window-picker").pick_window()

        if not win_id then
          return
        end

        vim.api.nvim_win_close(win_id, false)
      end,
      mode = { "n", "t", "i" },
      desc = "Pick window and close"
    }
  },
  config = function()
    require("window-picker").setup({
      hint = "floating-letter",
      show_prompt = false,
      picker_config = {
        statusline_winbar_picker = {
          use_winbar = "never",
        },
      },
      filter_rules = {
        autoselect_one = false,
        include_current_win = true,
        include_unfocusable_windows = true,
        bo = {
          filetype = { "notify" },
          buftype = {},
        },
        wo = {},
        file_path_contains = {},
        file_name_contains = {},
      },
      highlights = {
        enabled = true,
      }
    })
  end,
}
