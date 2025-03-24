return {
  pick_window_to_open_buf = function(filetypes, exceptions)
    local windows = vim.api.nvim_list_wins()

    if #windows == 1 then
      for _, win in ipairs(windows) do
        local buf = vim.api.nvim_win_get_buf(win)
        local filetype = vim.bo[buf].filetype

        for _, exception in ipairs(exceptions) do
          if exception == filetype then
            for i, ft in ipairs(filetypes) do
              if ft == exception then
                table.remove(filetypes, i)
              end
            end
          end
        end
      end
    end

    return require("window-picker").pick_window({
      filter_rules = {
        autoselect_one = true,
        bo = {
          filetype = filetypes
        }
      }
    })
  end
}
