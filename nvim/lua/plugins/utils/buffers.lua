local M = {}

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
          vim.cmd(selection.value.id .. "ToggleTerm")
        end
      end)
      return true
    end,
  }):find()
end

return M
