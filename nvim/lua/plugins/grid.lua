return {
  "ssgabrieldev/grid.nvim",
  enabled = true,
  lazy = false,
  config = function()
    require("grid").setup({
      layout = {
        {
          name = "Tree",
          type = "col",
          filters = { "NvimTree" },
          width = 35,
          bufferline = {
            events = {
              render = function(bufferline)
                local api = vim.api
                local fn = vim.fn
                local node = bufferline.node
                local current_buffer = node.current_buffer

                if current_buffer.filetype == "NvimTree" then
                  local win_width = api.nvim_win_get_width(node.window_id)
                  local text = "Explorer"
                  local plain_text = text:gsub("%%#.-#", ""):gsub("%%*", "")
                  local text_width = fn.strdisplaywidth(plain_text)
                  local padding = math.floor((win_width - text_width) / 2)

                  if padding < 0 then
                    padding = 0
                  end

                  local left_padding = string.rep(" ", padding)
                  local winbar_text = left_padding .. text

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
              filters = { "*" },
              bufferline = {
                maps = {
                  ["<tab>"] = {
                    modes = { "n" },
                    fn = function(bufferline)
                      bufferline:next()
                    end
                  },
                  ["<s-tab>"] = {
                    modes = { "n" },
                    fn = function(bufferline)
                      bufferline:prev()
                    end
                  }
                }
              }
            },
            {
              name = "Terminal",
              type = "row",
              filters = {
                "terminal",
                "toggleterm",
                "dap-view://main",
                "dap-view-term",
                "dap-repl",
                "qf"
              },
              height = 20,
              bufferline = {
                enabled = false
              }
            },
          },
        },
      }
    })
  end
}
