local theme_utils = require("plugins.utils.theme")
local ui_utils = require("plugins.utils.ui")
local config_path = vim.fn.stdpath('config')
local user_dir = config_path .. '/user'

vim.g.mapleader = ";"
vim.g.explore_is_open = false
vim.g.debugger_is_open = false
vim.g.terminal_is_open = false
vim.g.border_style = "rounded"
vim.g.theme = theme_utils.get_theme()

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

vim.api.nvim_create_user_command("ToggleTransparency", ui_utils.toggle_transparency, {})

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
vim.opt.timeout = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

vim.keymap.set({ "n" }, "<A-h>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease window width" })
vim.keymap.set({ "n" }, "<A-l>", ":vertical resize +2<CR>", { silent = true, desc = "Increase window width" })
vim.keymap.set({ "n" }, "<A-j>", ":resize -2<CR>", { silent = true, desc = "Decrease window height" })
vim.keymap.set({ "n" }, "<A-k>", ":resize +2<CR>", { silent = true, desc = "Increase window height" })
vim.keymap.set({ "i", "n", "v", "c" }, "<leader><leader>", "<esc>", { silent = false, desc = "Nomal mode" })
vim.keymap.set({ "t" }, "<leader><leader>", "<c-\\><c-n>", { silent = true, desc = "Exit terminal mode" })
vim.keymap.set({ "n" }, "<leader>wv", "<c-w>v", { silent = true, desc = "Split window vertical" })
vim.keymap.set({ "n" }, "<leader>ws", "<c-w>s", { silent = true, desc = "Split window horizontal" })
vim.keymap.set({ "n" }, "<leader><S-q><S-q>", ":q!<CR>", { silent = true, desc = "Close window without save buffer" })
vim.keymap.set({ "n" }, "<leader><S-q><S-a>", ":qa!<CR>", { silent = true, desc = "Close all windows, without save buffers" })
vim.keymap.set({ "n" }, "<leader>qq", ":q<CR>", { silent = true, desc = "Close window" })
vim.keymap.set({ "n" }, "<leader>qa", ":qa<CR>", { silent = true, desc = "Close all windows" })
vim.keymap.set({ "n", "i" }, "<leader>ww", "<cmd>w<CR>", { silent = true, desc = "Write buffer" })
vim.keymap.set({ "n" }, "<leader>wq", ":wq<CR>", { silent = true, desc = "Write buffer and quit" })
vim.keymap.set({ "n" }, "<leader>wa", ":wa<CR>", { silent = true, desc = "Write all buffers" })
vim.keymap.set({ "v" }, "<leader>y", "\"+y", { silent = true, desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", { silent = true, desc = "Paste from clipboard" })
vim.keymap.set({ "v" }, "<leader>[", "da[]<esc><s-p>", { silent = true, desc = "Sunround by brackets" })
vim.keymap.set({ "n" }, "<leader>[", "di[va[p", { silent = true, desc = "Remove brackets" })
vim.keymap.set({ "v" }, "<leader>(", "da()<esc><s-p>", { silent = true, desc = "Sunround by parentheses" })
vim.keymap.set({ "n" }, "<leader>(", "di(va(p", { silent = true, desc = "Remove parentheses" })
vim.keymap.set({ "v" }, "<leader>{", "da{}<esc><s-p>", { silent = true, desc = "Sunround by keys" })
vim.keymap.set({ "n" }, "<leader>{", "di{va{p", { silent = true, desc = "Remove keys" })
vim.keymap.set({ "v" }, "<leader>`", "da``<esc><s-p>", { silent = true, desc = "Sunround by crasis" })
vim.keymap.set({ "n" }, "<leader>`", "di`va`p", { silent = true, desc = "Remove crasis" })
vim.keymap.set({ "v" }, "<leader>'", "da''<esc><s-p>", { silent = true, desc = "Sunround by single quotes" })
vim.keymap.set({ "n" }, "<leader>'", "di'va'p", { silent = true, desc = "Remove single quotes" })
vim.keymap.set({ "v" }, "<leader>\"", "da\"\"<esc><s-p>", { silent = true, desc = "Sunround by quotes" })
vim.keymap.set({ "n" }, "<leader>\"", "di\"va\"p", { silent = true, desc = "Remove quotes" })
vim.keymap.set({ "n" }, "<leader>rr", "<cmd>source ~/.config/nvim/init.lua<cr>", { silent = true, desc = "Reload init.lua" })
vim.keymap.set({ "n" }, "<leader>co", "<cmd>e ~/.config/nvim/<cr>", { silent = true, desc = "Open configurations" })

if vim.g.theme then
  vim.cmd("color " .. vim.g.theme)
end
