local M = {}

local border = vim.g.border_style
local opts = { noremap = true, silent = true }

M.handlers = {
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = border, max_width = 80, max_height = 40 }
  ),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = border }
  ),
}

M.capabilities = vim.lsp.protocol.make_client_capabilities({})

M.capabilities.textDocument.completion.completionItem.snippetSupport = true

local signs = {
  Error = "", -- mais discreto
  Warn  = "",
  Hint  = "󰌶",
  Info  = "󰋽",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  float = {
    border = border
  },
  signs = true
})

require("lspconfig.ui.windows").default_options = {
  border = border
}

M.on_attach = function(_, bufnr)
  local bufopts = {
    noremap = true,
    silent = true,
    buffer = bufnr,
  }
  vim.keymap.set(
    "n",
    "<LEADER>ld",
    vim.lsp.buf.definition,
    bufopts
  )
  vim.keymap.set(
    { "n", "i", "v" },
    "<LEADER>lf",
    function() vim.lsp.buf.format({ async = true }) end,
    bufopts
  )
  vim.keymap.set(
    "n",
    "<LEADER>lh",
    function()
      vim.lsp.buf.hover()
    end,
    bufopts
  )
  vim.keymap.set(
    "n",
    "<LEADER>lr",
    vim.lsp.buf.rename,
    bufopts
  )
  vim.keymap.set(
    "n",
    "<LEADER>la",
    vim.lsp.buf.code_action,
    opts
  )
  vim.keymap.set(
    "n",
    "<LEADER>le",
    function()
      vim.diagnostic.open_float()
    end,
    opts
  )
end

return M
