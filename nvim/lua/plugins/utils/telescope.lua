local window_picker_utils = require("plugins.utils.window-picker")

local M = {}

M.get_propper_window = function(prompt_bufnr, picker)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry = action_state.get_selected_entry()

  if not entry then
    return
  end

  local filepath = entry.path or entry[1]
  actions.close(prompt_bufnr)

  local win_id = window_picker_utils.pick_window_to_open_buf(
    {
      "NvimTree",
      "toggleterm",
      "dapui_watches",
      "dapui_stacks",
      "dapui_breakpoints",
      "dapui_scopes",
      "dapui_console",
      "dap-repl",
      "notify"
    },
    {
      "NvimTree"
    }
  )

  if not win_id then
    return
  end

  vim.api.nvim_set_current_win(win_id)

  vim.cmd("edit " .. vim.fn.fnameescape(filepath))

  if picker == "live_grep" then
    local line = entry.lnum
    local col = entry.col
    vim.api.nvim_win_set_cursor(0, { line, col })
  end
end

return M
