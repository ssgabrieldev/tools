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

M.get_propper_window = function(prompt_bufnr, picker)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry = action_state.get_selected_entry()

  if not entry then
    return
  end

  local filepath = entry.path or entry[1]
  actions.close(prompt_bufnr)

  local win_id = require("window-picker").pick_window({
    filter_rules = {
      autoselect_one = true,
      bo = {
        filetype = {
          "NvimTree",
          "toggleterm",
          "dapui_watches",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dap-repl",
          "notify"
        }
      }
    }
  })

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
