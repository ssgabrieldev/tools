local ui_utils = require("plugins.utils.ui")
local config_path = vim.fn.stdpath('config')
local user_dir = config_path .. '/user'

vim.g.mapleader = ";"
vim.g.explore_is_open = false
vim.g.debugger_is_open = false
vim.g.terminal_is_open = false
vim.g.border_style = "rounded"
vim.g.theme = ui_utils.get_theme()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

if vim.fn.isdirectory(user_dir) == 0 then
  vim.fn.mkdir(user_dir, 'p')
end

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

require("plugins.utils.aucmd")
require("plugins.utils.commands")

vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
-- vim.opt.clipboard = "unnamedplus"
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
vim.opt.timeout = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

require("plugins.utils.keymap")

if vim.g.theme then
  vim.cmd("color " .. vim.g.theme)
end
