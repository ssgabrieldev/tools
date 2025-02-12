return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      -- opts = {
      --   diagnostics = {
      --     signs = {
      --       text = {
      --         [vim.diagnostic.severity.ERROR] = "",
      --         [vim.diagnostic.severity.WARN] = "",
      --         [vim.diagnostic.severity.HINT] = "",
      --         [vim.diagnostic.severity.INFO] = "",
      --       },
      --       numhl = {
      --         [vim.diagnostic.severity.WARN] = "WarningMsg",
      --         [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      --         [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      --         [vim.diagnostic.severity.HINT] = "DiagnosticHint",
      --       },
      --     },
      --   }
      -- }
    }
  },
  opts = {
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "emmet_ls",
      "cssls"
    }
  },
  init = function()
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
        },
        numhl = {
          [vim.diagnostic.severity.WARN] = 'WarningMsg',
          [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
          [vim.diagnostic.severity.HINT] = 'DiagnosticHint',

        },
      },
    })
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        local utils_lsp = require('plugins.utils.lsp')

        require("lspconfig")[server_name].setup({
          on_attach = utils_lsp.on_attach,
          capabilities = utils_lsp.capabilities,
          handlers = utils_lsp.handlers,
        })
      end,
      ["emmet_ls"] = function(server_name)
        local utils_lsp = require('plugins.utils.lsp')

        require("lspconfig")[server_name].setup({
          filetypes = { 'html', 'typescriptreact', 'javascriptreact' },
          on_attach = utils_lsp.on_attach,
          capabilities = utils_lsp.capabilities,
          handlers = utils_lsp.handlers,
        })
      end
    })
  end
}
