return {
  -- "ssgabrieldev/knot.nvim",
  dir = "~/Documentos/projects/nvim/knot.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    vim.cmd("color knot")
  end,
}
