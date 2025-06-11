return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    wo = {
      winbar = false,
      winfixwidth = false,
      winfixheight = false
    },
    animate = {
      enabled = false
    },
    left = {
      {
        ft = "NvimTree"
      }
    },
    bottom = {
      {
        ft = "toggleterm",
        size = { height = 15 },
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end
      },
      {
        ft = "dap-view-term",
        size = { height = 15 },
        wo= {
          number = false
        }
      },
      {
        ft = "dap-repl",
        size = { height = 15 },
      },
      {
        ft = "dap-view",
        size = { height = 15 },
      },
      {
        ft = "qf"
      }
    },
    keys = {
      ["<a-j>"] = function(win)
        win:resize("height", -2)
      end,
      ["<a-k>"] = function(win)
        win:resize("height", 2)
      end,
      ["<a-h>"] = function(win)
        win:resize("width", -2)
      end,
      ["<a-l>"] = function(win)
        win:resize("width", 2)
      end,
      ["<leader>w="] = function(win)
        win.view.edgebar:equalize()
      end,
      ["q"] = function() end,
      ["<c-q>"] = function() end,
      ["Q"] = function() end,
      ["]w"] = function() end,
      ["[w"] = function() end,
      ["]W"] = function() end,
      ["[W"] = function() end,
      ["<c-w>>"] = function() end,
      ["<c-w><lt>"] = function() end,
      ["<c-w>+"] = function() end,
      ["<c-w>-"] = function() end,
    }
  }
}
