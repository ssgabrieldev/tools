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

M.list_toggleterm = function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local toggleterm = require("toggleterm.terminal")
  local terminals = toggleterm.get_all()

  local results = {}
  for _, term in pairs(terminals) do
    table.insert(results, {
      id = term.id,
      cmd = term.cmd or "Shell",
    })
  end

  pickers.new({}, {
    prompt_title = "ToggleTerm Terminals",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = string.format("ID: %d | Cmd: %s", entry.id, entry.cmd),
          ordinal = tostring(entry.id),
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        -- Abrir o terminal selecionado
        if selection then
          M.close_for_terminal(function ()
            vim.cmd(selection.value.id .. "ToggleTerm")
          end)
        end
      end)
      return true
    end,
  }):find()
end

return M
