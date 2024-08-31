local M = {}

M.close_for_terminal = function(open_terminal)
  local is_terminal = vim.bo.filetype == "toggleterm"

  open_terminal()

  if is_terminal then
    return
  end

  local tree_module = "nvim-tree"
  if package.loaded[tree_module] and require(tree_module .. ".view").is_visible() then
    local tree_focus_command = "NvimTreeFocus"
    local tree_resize_command = "NvimTreeResize 30"
    vim.cmd(tree_focus_command)
    vim.cmd("wincmd H")
    vim.cmd("wincmd p")
    vim.cmd(tree_resize_command)
  end

  local dap_module = "dapui"
  if package.loaded[dap_module] then
    require(dap_module).close()
  end
end

M.go_to_buf_file = function()
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

return M
