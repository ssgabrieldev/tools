return {
  "goolord/alpha-nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.opts.layout[1].val = 8

    dashboard.section.header.val = {
      "   ⠀⠀⠀⢀⣤⣶⣾⣿⣿⣿⣷⣶⣤⡀",
      "   ⠀⠀⣼⣿⡿⠛⠉⠙⠛⠻⣿⣿⣿⣿⡄",
      "   ⠀⠸⠿⠋⠀⠀NEOVIM⠀⠀⠙⠻⠿⠇",
    }

    dashboard.section.buttons.val = {
      dashboard.button("<leader>nn", "  New File", ":ene <BAR> startinsert <CR>"),
      dashboard.button("<leader>ee", "  Explorer", ":NvimTreeToggle<CR>"),
      dashboard.button("<leader>ff", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("<leader>fw", "  Find Word", ":Telescope live_grep<CR>"),
      dashboard.button("<leader>qa", "x  Exit", ":qa<CR>"),
    }

    dashboard.section.footer.val = {
      "VIM is the way"
    }

    alpha.setup(dashboard.opts)
  end,
  keys = {
    {
      "<leader>MM",
      function()
        vim.cmd("wincmd o")
        vim.cmd("Alpha")
      end,
      mode = { "i", "n", "t" },
      desc = "Open initial menu"
    },
  }
}
