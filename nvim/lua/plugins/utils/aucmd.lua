local open_buffer = function(handler)
  local win_id = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(win_id)

  if config.relative ~= "" then
    return
  end

  local current_buf_id = vim.api.nvim_win_get_buf(win_id)

  local file_type = vim.bo[current_buf_id].filetype

  handler(file_type)
end

local open_term_buffer = function(file_type)
  if file_type == "toggleterm" then
    local win_id = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_get_current_buf()

    local au_id = vim.api.nvim_create_autocmd("BufWinEnter", {
      group = augroup,
      callback = function()
        local id_win = vim.api.nvim_get_current_win()

        if id_win == win_id then
          vim.api.nvim_set_current_buf(buf)
        end
      end
    })

    vim.api.nvim_create_autocmd("WinClosed", {
      once = true,
      callback = function()
        local id_win = vim.api.nvim_get_current_win()

        if id_win == win_id then
          vim.api.nvim_del_autocmd(au_id)
        end
      end
    })

    vim.g.terminal_is_open = true
    require("dapui").close()
    vim.g.debugger_is_open = false

    if vim.g.explore_is_open then
      local tree_focus_command = "NvimTreeFocus"
      local tree_resize_command = "NvimTreeResize 30"
      vim.cmd(tree_focus_command)
      vim.cmd("wincmd H")
      vim.cmd("wincmd p")
      vim.cmd(tree_resize_command)
    end
  end
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.cmd("ColorizerAttachToBuffer")

    open_buffer(function(file_type)
      if file_type == "NvimTree" then
        vim.g.explore_is_open = true
        require("dapui").close()
        vim.g.debugger_is_open = false
      end

      if file_type == "dapui_watches" then
        vim.g.debugger_is_open = true
        vim.cmd("NvimTreeClose")
        vim.g.explore_is_open = false

        if vim.g.terminal_is_open then
          vim.cmd("ToggleTerm")
          vim.g.terminal_is_open = false
        end
      end

      open_term_buffer(file_type)
    end)
  end
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    open_buffer(open_term_buffer)
  end
})

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function(args)
    local win_id = tonumber(args.match)
    if not win_id then
      return
    end

    local config = vim.api.nvim_win_get_config(win_id)

    if config.relative ~= "" then
      return
    end

    local buf = vim.api.nvim_win_get_buf(win_id)
    local file_type = vim.bo[buf].filetype

    if file_type == "toggleterm" then
      vim.g.terminal_is_open = false
    end

    if file_type == "NvimTree" then
      vim.g.explore_is_open = false
    end

    if
        file_type == "dapui_watches"
        or file_type == "dapui_stacks"
        or file_type == "dapui_breakpoints"
        or file_type == "dapui_scopes"
        or file_type == "dapui_console"
        or file_type == "dap-repl"
    then
      vim.g.debugger_is_open = false
    end
  end,
})
