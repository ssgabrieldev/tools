local utils_buffers = require("plugins.utils.buffers")

local get_propper_window = function(prompt_bufnr)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry = action_state.get_selected_entry()
  local filepath = entry.path or entry[1]
  actions.close(prompt_bufnr)

  local win_id = require("window-picker").pick_window({
    filter_rules = {
      autoselect_one = true,
      bo = {
        filetype = {
          "NvimTree",
          "toggleterm",
          "dapui_watches",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dap-repl",
        }
      }
    }
  })

  if not win_id then
    return
  end

  vim.api.nvim_set_current_win(win_id)

  vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end

local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    's1n7ax/nvim-window-picker',
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope-dap.nvim",
    'akinsho/toggleterm.nvim',
  },
  keys = {
    {
      "<leader>ff",
      function()
        -- go_to_buf_file()
        vim.cmd("Telescope find_files")
      end,
      desc = "Find file"
    },
    {
      "<leader>fw",
      function()
        go_to_buf_file()
        vim.cmd("Telescope live_grep")
      end,
      desc = "Find pattern"
    },
    {
      "<leader>fb",
      function()
        go_to_buf_file()
        vim.cmd("Telescope buffers")
      end,
      desc = "Find buffer"
    },
    {
      "<leader>fg",
      function()
        go_to_buf_file()
        vim.cmd("Telescope git_status")
      end,
      desc = "Find git change"
    },
    {
      "<leader>fk",
      function()
        go_to_buf_file()
        vim.cmd("Telescope keymaps")
      end,
      desc = "Find keymap"
    },
    {
      "<leader>ft",
      function()
        utils_buffers.list_toggleterm()
      end,
      mode = { "t", "n" },
      desc = "Find terminal"
    }
  }
}

function M.config()
  require("telescope").setup({
    defaults = {
      preview = true,
    },
    pickers = {
      find_files = {
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              get_propper_window(prompt_bufnr)
            end,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              get_propper_window(prompt_bufnr)
            end,
          },
        },
      },
      buffers = {
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              get_propper_window(prompt_bufnr)
            end,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              get_propper_window(prompt_bufnr)
            end,
          },
        },
      },
      live_grep = {
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              get_propper_window(prompt_bufnr)
            end,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              get_propper_window(prompt_bufnr)
            end,
          },
        },
      },
      git_status = {
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              get_propper_window(prompt_bufnr)
            end,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              get_propper_window(prompt_bufnr)
            end,
          },
        },
      },
    }
  })
end

return M
