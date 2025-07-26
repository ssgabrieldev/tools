local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.g.mapleader = ";"
vim.g.border_style = "single"

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

vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true

local tab_len = 4
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.cursorline = true
vim.opt.tabstop = tab_len
vim.opt.softtabstop = tab_len
vim.opt.shiftwidth = tab_len
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

vim.o.confirm = true

require("keymaps")
