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

vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.splitright = true
vim.opt.smartindent = true
vim.opt.scrolloff = 5
vim.opt.termsync = false
vim.opt.colorcolumn = "80"
vim.opt.timeout = false

vim.keymap.set('n', '<s-w>', '<c-w>', { silent = true })
vim.keymap.set('n', '<A-h>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<A-l>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<A-j>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<A-k>', ':resize +2<CR>', { silent = true })
vim.keymap.set('t', '<leader><leader>', '<c-\\><c-n>', { silent = true })
vim.keymap.set('n', '<leader><S-q><S-q>', ':q!<CR>', { silent = true })
vim.keymap.set('n', '<leader><S-q><S-a>', ':qa!<CR>', { silent = true })
vim.keymap.set('n', '<leader>qq', ':q<CR>', { silent = true })
vim.keymap.set('n', '<leader>qa', ':qa<CR>', { silent = true })
vim.keymap.set('n', '<leader>ww', ':w<CR>', { silent = true })
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { silent = true })
vim.keymap.set('n', '<leader>wa', ':wa<CR>', { silent = true })
vim.keymap.set("n", "<leader>rr", ":so ~/.config/nvim/init.lua<CR>", { silent = true })
vim.keymap.set("v", "<leader>y", "\"+y", { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", { silent = true })

vim.opt.clipboard = "unnamedplus"
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
