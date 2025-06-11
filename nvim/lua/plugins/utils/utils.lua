return {
  close_buffers = function(fts)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_buf_get_option(buf, "filetype")
      for _, v in ipairs(fts) do
        if v == ft then
          vim.api.nvim_win_close(win, true)
        end
      end
    end
  end
}
