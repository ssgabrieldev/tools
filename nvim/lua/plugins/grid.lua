return {
  "ssgabrieldev/grid.nvim",
  enabled = true,
  lazy = false,
  dependecies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("grid").setup({
      layout = {
        {
          name = "Tree",
          type = "col",
          width = 35,
          buffer_match = function(buffer)
            local filetypes = { "NvimTree" }

            return vim.tbl_contains(filetypes, buffer:filetype())
          end,
          winbar = {
            events = {
              render = function(winbar)
                local api = vim.api
                local fn = vim.fn
                local node = winbar.node
                local current_buffer = node.current_buffer

                if current_buffer:filetype() == "NvimTree" then
                  local win_width = api.nvim_win_get_width(node.window_id)
                  local text = "Explorer"
                  local plain_text = text:gsub("%%#.-#", ""):gsub("%%*", "")
                  local text_width = fn.strdisplaywidth(plain_text)
                  local padding = math.floor((win_width - text_width) / 2)

                  if padding < 0 then
                    padding = 0
                  end

                  local left_padding = string.rep(" ", padding)
                  local winbar_text = "%#WinBarSelected#" .. left_padding .. text

                  vim.defer_fn(function()
                    api.nvim_set_option_value(
                      "winbar",
                      winbar_text,
                      {
                        win = node.window_id
                      }
                    )
                  end, 1)
                end
              end
            }
          }
        },
        {
          name = "Editor Container",
          type = "col",
          children = {
            {
              name = "Editor",
              type = "row",
              buffer_match = function(buffer)
                local node = buffer:get_node()
                local match = not node
                    and (
                      buffer:is_listed()
                      or buffer:filetype() ~= ""
                    )

                if match then
                  return true
                end

                return false
              end,
              winbar = {
                maps = {
                  ["<tab>"] = {
                    modes = { "n" },
                    fn = function(winbar)
                      winbar:next()
                    end
                  },
                  ["<s-tab>"] = {
                    modes = { "n" },
                    fn = function(winbar)
                      winbar:prev()
                    end
                  }
                }
              }
            },
            {
              name = "Terminal",
              type = "row",
              height = 15,
              buffer_match = function(buffer)
                local filetype = vim.bo[buffer.id].filetype
                local filetypes = {
                  "terminal",
                  "toggleterm",
                  "dap-view://main",
                  "dap-view-term",
                  "dap-view",
                  "dap-repl",
                  "qf"
                }

                return vim.tbl_contains(filetypes, filetype)
              end,
              winbar = {
                enabled = false
              },
            },
          },
        },
      }
    })
  end
}
