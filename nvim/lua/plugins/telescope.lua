return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
  },
  init = function()
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("live_grep_args")
  end,
  opts = {
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({})
      }
    },
    defaults = {
      preview = true,
      layout_strategy = "horizontal",
      sorting_strategy = "descending",
      borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
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
    }
  },
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
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      mode = { "n", "t" },
      desc = "Find pattern with args"
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
    }
  },
}
