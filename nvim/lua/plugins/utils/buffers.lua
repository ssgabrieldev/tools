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

return M
