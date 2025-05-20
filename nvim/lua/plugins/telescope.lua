local utils_telescope = require("plugins.utils.telescope")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "s1n7ax/nvim-window-picker",
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope-dap.nvim",
    "akinsho/toggleterm.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
  },
  opts = {
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({})
      }
    },
    defaults = {
      preview = true,
      layout_strategy = "horizontal",
      sorting_strategy = "ascending",
      borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      layout_config = {
        horizontal = {
          prompt_position = "top",
          height = 0.8,
          width = 0.8
        },
      },
      file_ignore_patterns = {
        "node_modules",
        ".git/"
      },
      mappings = {
        n = {
          ["<leader><leader>"] = require("telescope.actions").close
        }
      }
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
    require("telescope").load_extension("live_grep_args")
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = true,
        })
      end,
      mode = { "n", "t" },
      desc = "Find file"
    },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").live_grep({
          hidden = true,
          no_ignore = true,
        })
      end,
      mode = { "n", "t" },
      desc = "Find pattern"
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      mode = { "n", "t" },
      desc = "Find buffer"
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").git_status()
      end,
      mode = { "n", "t" },
      desc = "Find git change"
    },
    {
      "<leader>fk",
      function()
        require("telescope.builtin").keymaps()
      end,
      mode = { "n", "t" },
      desc = "Find keymap"
    },
    {
      "<leader>ft",
      function()
        utils_telescope.list_toggleterm()
      end,
      mode = { "n", "t" },
      desc = "Find terminal"
    },
    {
      "<leader>fc",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = true,
          cwd = "~/.config/nvim"
        })
      end,
      mode = { "n", "t" },
      desc = "Find config files"
    },
    {
      "<leader>fp",
      function()
        utils_telescope.reload_plugin()
      end,
      mode = { "n", "t" },
      desc = "Reload plugin"
    },
    {
      "<leader>fT",
      function()
        utils_telescope.list_themes()
      end,
      mode = { "n", "t" },
      desc = "Change theme"
    },
    {
      "<leader>fW",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      mode = { "n", "t" },
      desc = "Find pattern with args"
    }
  },
}
