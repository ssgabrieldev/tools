local M = {}

M.close_for_terminal = function(open_terminal)
  local is_terminal = vim.bo.filetype == "toggleterm"

  open_terminal()

  if is_terminal then
    return
  end

  if vim.g.explore_is_open then
    local tree_focus_command = "NvimTreeFocus"
    local tree_resize_command = "NvimTreeResize 30"
    vim.cmd(tree_focus_command)
    vim.cmd("wincmd H")
    vim.cmd("wincmd p")
    vim.cmd(tree_resize_command)
  end

  local dap_module = "dapui"
  if vim.g.debugger_is_open then
    require(dap_module).close()
    vim.g.debugger_is_open = false
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
          M.close_for_terminal(function()
            vim.cmd(selection.value.id .. "ToggleTerm")
            vim.g.terminal_is_open = not vim.g.terminal_is_open
          end)
        end
      end)
      return true
    end,
  }):find()
end

return M
