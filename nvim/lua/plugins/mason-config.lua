local M = {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  dependencies = {
    "neovim/nvim-lspconfig"
  },
}

function M.config()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "emmet_ls",
      "cssls"
    }
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

return M
