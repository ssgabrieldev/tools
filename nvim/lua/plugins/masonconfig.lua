local g = vim.g
local diagnostic = vim.diagnostic
local lsp = vim.lsp
local api = vim.api
local fn = vim.fn
local keymap = vim.keymap

return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "emmet_ls",
      "cssls"
    },
    automatic_enable = true
  },
  init = function()
    local border = g.border_style or "rounded"

    local signs = {
      Error = "",
      Warn  = "",
      Hint  = "󰌶",
      Info  = "󰋽",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    diagnostic.config({
      float = { border = border },
      signs = true,
      virtual_text = {
        prefix = ' ',
        spacing = 1,
      }
    })

    require("lspconfig.ui.windows").default_options = {
      border = border
    }

    local opts = { noremap = true, silent = true }
    local lsp_config = {
      capabilities = lsp.protocol.make_client_capabilities(),
    }

    keymap.set("n", "<leader>ld", lsp.buf.definition, opts)
    keymap.set("n", "<leader>lr", lsp.buf.rename, opts)
    keymap.set("n", "<leader>la", lsp.buf.code_action, opts)
    keymap.set({ "n", "v" }, "<leader>lf", function()
      lsp.buf.format({ async = true })
    end, opts)
    keymap.set("n", "<leader>lh", function()
      lsp.buf.hover({
        border = border,
        max_width = 45,
        max_height = 35
      })
    end, opts)
    keymap.set("n", "<leader>le", function()
      diagnostic.open_float()
    end, opts)

    lsp.config("*", lsp_config)
  end
}
