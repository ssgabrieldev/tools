return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
    }
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
    local border = vim.g.border_style or "rounded"

    local signs = {
      Error = "",
      Warn  = "",
      Hint  = "󰌶",
      Info  = "󰋽",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.diagnostic.config({
      float = { border = border },
      signs = true,
    })

    require("lspconfig.ui.windows").default_options = {
      border = border
    }

    local opts = { noremap = true, silent = true }

    vim.lsp.config("*", {
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover,
          { border = border, max_width = 80, max_height = 40 }
        ),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = border }
        ),
      },

      capabilities = vim.lsp.protocol.make_client_capabilities(),

      on_attach = function(client, bufnr)
        local bufopts = {
          noremap = true,
          silent = true,
          buffer = bufnr,
        }

        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, bufopts)
        vim.keymap.set({ "n", "i", "v" }, "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>le", function()
          vim.diagnostic.open_float()
        end, opts)
      end,
    })
  end
}
