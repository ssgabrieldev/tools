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
      name = term.display_name or term.name,
      term = term
    })
  end

  pickers.new({}, {
    prompt_title = "Terminals",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = string.format("ID: %d | Cmd: %s", entry.id, entry.name),
          ordinal = tostring(entry.id),
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      map({ "i", "n" }, "<cr>", function()
        local selection = action_state.get_selected_entry()

        actions.close(prompt_bufnr)

        if selection then
          vim.cmd(selection.value.id .. "ToggleTerm")
        end
      end)
      map({ "i", "n" }, "<leader>x", function()
        local selection = action_state.get_selected_entry()

        if selection then
          vim.api.nvim_buf_delete(selection.value.term.bufnr, { force = true })
        end

        actions.close(prompt_bufnr)
      end)
      map({ "i", "n" }, "<leader>f", function()
        local selection = action_state.get_selected_entry()

        actions.close(prompt_bufnr)

        if selection then
          vim.cmd(selection.value.id .. "ToggleTerm direction=float")
        end
      end)
      map({ "i", "n" }, "<leader>h", function()
        local selection = action_state.get_selected_entry()

        actions.close(prompt_bufnr)

        if selection then
          vim.cmd(selection.value.id .. "ToggleTerm direction=horizontal")
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

M.reload_plugin = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local sorters = require("telescope.config").values.generic_sorter
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local plugins = require("lazy.core.config").plugins
  local plugin_list = {}

  for _, plugin in pairs(plugins) do
    table.insert(plugin_list, {
      value = plugin.name,
      display = plugin.name,
      ordinal = plugin.name
    })
  end

  local on_select = function(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    actions.close(prompt_bufnr)
    require("lazy").reload({
      plugins = { selection.value }
    })
  end

  pickers.new({}, {
    prompt_title = "Lazy.nvim Plugins",
    finder = finders.new_table({
      results = plugin_list,
      entry_maker = function(entry)
        return {
          value = entry.value,
          display = entry.display,
          ordinal = entry.ordinal,
        }
      end,
    }),
    sorter = sorters({}),
    attach_mappings = function(_, map)
      map("i", "<CR>", on_select)
      map("n", "<CR>", on_select)
      return true
    end,
  }):find()
end

M.list_themes = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local available_colorschemes = vim.fn.getcompletion('', 'color')

  local on_select = function(prompt_bufnr)
    local selection = action_state.get_selected_entry(prompt_bufnr)

    vim.cmd('colorscheme ' .. selection[1])

    local config_path = vim.fn.stdpath('config')
    local theme_file = config_path .. '/user/theme.txt'
    local file = io.open(theme_file, 'w')

    if file then
      vim.g.theme = selection[1]

      file:write(vim.g.theme)
      file:close()

      print('Color scheme saved to ' .. theme_file)
    else
      print('Error: Could not save color scheme to ' .. theme_file)
    end

    actions.close(prompt_bufnr)
  end

  pickers.new(colorschemes, {
    prompt_title = "Themes",
    finder = finders.new_table({
      results = available_colorschemes,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      map('n', '<CR>', function()
        on_select(prompt_bufnr)
      end)
      map('i', '<CR>', function()
        on_select(prompt_bufnr)
      end)
      return true
    end,
  }):find()
end

return M
