local utils_telescope = require("plugins.utils.telescope")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    's1n7ax/nvim-window-picker',
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope-dap.nvim",
    'akinsho/toggleterm.nvim',
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = {
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({})
      }
    },
    defaults = {
      preview = true,
      file_ignore_patterns = {
        "node_modules",
        ".git"
      },
    },
    pickers = {
      find_files = {
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              utils_telescope.get_propper_window(prompt_bufnr)
            end,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              utils_telescope.get_propper_window(prompt_bufnr)
            end,
          },
        },
      },
      buffers = {
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              utils_telescope.get_propper_window(prompt_bufnr)
            end,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              utils_telescope.get_propper_window(prompt_bufnr)
            end,
          },
        },
      },
      live_grep = {
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              utils_telescope.get_propper_window(prompt_bufnr, "live_grep")
            end,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              utils_telescope.get_propper_window(prompt_bufnr)
            end,
          },
        },
      },
      git_status = {
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              utils_telescope.get_propper_window(prompt_bufnr)
            end,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              utils_telescope.get_propper_window(prompt_bufnr)
            end,
          },
        },
      },
    },
  },
  init = function()
    require("telescope").load_extension("ui-select")
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require('telescope.builtin').find_files({
          hidden = true,
          no_ignore = true,
        })
      end,
      desc = "Find file"
    },
    {
      "<leader>fw",
      function()
        require('telescope.builtin').live_grep({
          hidden = true,
          no_ignore = true,
        })
      end,
      desc = "Find pattern"
    },
    {
      "<leader>fb",
      function()
        vim.cmd("Telescope buffers")
      end,
      desc = "Find buffer"
    },
    {
      "<leader>fg",
      function()
        vim.cmd("Telescope git_status")
      end,
      desc = "Find git change"
    },
    {
      "<leader>fk",
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = "Find keymap"
    },
    {
      "<leader>ft",
      function()
        utils_telescope.list_toggleterm()
      end,
      mode = { "t", "n" },
      desc = "Find terminal"
    },
    {
      "<leader>fc",
      function()
        require('telescope.builtin').find_files({
          hidden = true,
          no_ignore = true,
          cwd = "~/.config/nvim"
        })
      end,
      desc = "Find config files"
    },
    {
      "<leader>RR",
      function()
        utils_telescope.reload_plugin()
      end,
      mode = { "n" },
      desc = "Reload plugin"
    }
  },
}
