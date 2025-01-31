vim.g.border_style = "rounded"
vim.g.mapleader = ";"
vim.g.explore_is_open = false
vim.g.debugger_is_open = false
vim.g.terminal_is_open = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
if vim.fn.executable("/usr/bin/fish") == 1 then
  vim.o.shell = "/usr/bin/fish"
end

if vim.env.SSH_TTY then
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end

local open_buffer = function(handler)
  local win_id = vim.api.nvim_get_current_win()      -- Get the current window ID
  local config = vim.api.nvim_win_get_config(win_id) -- Get the window's configuration

  if config.relative ~= "" then
    return
  end

  local current_buf_id = vim.api.nvim_win_get_buf(win_id)

  local file_type = vim.bo[current_buf_id].filetype

  handler(file_type)
end

local open_term_buffer = function(file_type)
  if file_type == "toggleterm" then
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

vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = true
vim.opt.directory = "/tmp//"
vim.opt.splitright = true
vim.opt.smartindent = true
vim.opt.scrolloff = 5
vim.opt.termsync = false
vim.opt.colorcolumn = "80"
vim.opt.timeout = false

vim.keymap.set({ 'n' }, '<A-h>', ':vertical resize -2<CR>', { silent = true, dec = "Decrease window width"})
vim.keymap.set({ 'n' }, '<A-l>', ':vertical resize +2<CR>', { silent = true, dec = "Increase window width" })
vim.keymap.set({ 'n' }, '<A-j>', ':resize -2<CR>', { silent = true, dec = "Decrease window height" })
vim.keymap.set({ 'n' }, '<A-k>', ':resize +2<CR>', { silent = true, dec = "Increase window height" })
vim.keymap.set({ "i", "n" }, '<leader><leader>', '<esc>', { silent = true, desc = "Nomal mode" })
vim.keymap.set({ 't', }, '<leader><leader>', '<c-\\><c-n>', { silent = true, desc = "Exit terminal mode" })
vim.keymap.set({ 'n' }, '<leader><S-q><S-q>', ':q!<CR>', { silent = true, desc = "Close window without save buffer" })
vim.keymap.set({ 'n' }, '<leader><S-q><S-a>', ':qa!<CR>', { silent = true, desc="Close all windows, without save buffers" })
vim.keymap.set({ 'n' }, '<leader>qq', ':q<CR>', { silent = true, desc="Close window" })
vim.keymap.set({ 'n' }, '<leader>qa', ':qa<CR>', { silent = true, desc="Close all windows" })
vim.keymap.set({ 'n' }, '<leader>ww', ':w<CR>', { silent = true, desc="Write buffer" })
vim.keymap.set({ 'n' }, '<leader>wq', ':wq<CR>', { silent = true, desc="Write buffer and quit" })
vim.keymap.set({ 'n' }, '<leader>wa', ':wa<CR>', { silent = true, desc="Write all buffers" })
vim.keymap.set({ "n" }, "<leader>rr", ":so ~/.config/nvim/init.lua<CR>", { silent = true, desc="Reload configs" })
vim.keymap.set({ "n" }, "<leader>co", ":e ~/.config/nvim/<CR>", { silent = true, desc="Open configs" })
vim.keymap.set({ "v" }, "<leader>y", "\"+y", { silent = true, desc="Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", { silent = true, desc="Paste from clipboard" })
vim.keymap.set({ "v" }, "<leader>[", "di[]<esc><s-p>", { silent = true, desc="Sunround by brackets" })
vim.keymap.set({ "n" }, "<leader>[", "di[va[p", { silent = true, desc="Remove brackets" })
vim.keymap.set({ "v" }, "<leader>(", "di()<esc><s-p>", { silent = true, desc="Sunround by parentheses" })
vim.keymap.set({ "n" }, "<leader>(", "di(va(p", { silent = true, desc="Remove parentheses" })
vim.keymap.set({ "v" }, "<leader>{", "di{}<esc><s-p>", { silent = true, desc="Sunround by keys" })
vim.keymap.set({ "n" }, "<leader>{", "di{va{p", { silent = true, desc="Remove keys" })
vim.keymap.set({ "v" }, "<leader>`", "di``<esc><s-p>", { silent = true, desc="Sunround by crasis" })
vim.keymap.set({ "n" }, "<leader>`", "di`va`p", { silent = true, desc="Remove crasis" })
vim.keymap.set({ "v" }, "<leader>'", "di''<esc><s-p>", { silent = true, desc="Sunround by single quotes" })
vim.keymap.set({ "n" }, "<leader>'", "di'va'p", { silent = true, desc="Remove single quotes" })
vim.keymap.set({ "v" }, "<leader>\"", "di\"\"<esc><s-p>", { silent = true, desc="Sunround by quotes" })
vim.keymap.set({ "n" }, "<leader>\"", "di\"va\"p", { silent = true, desc="Remove quotes" })

