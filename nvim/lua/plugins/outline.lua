return {
  "hedyhli/outline.nvim",
  config = function()
    require("outline").setup({})
  end,
  keys = {
    {
      "<leader>ol",
      function()
        vim.cmd("Outline")
      end,
      mode = { "n" },
      { desc = "Outline" }
    },
    {
      "<leader>of",
      function()
        vim.cmd("OutlineFocus")
      end,
      mode = { "n" },
      { desc = "Outline" }
    }
  }
}
