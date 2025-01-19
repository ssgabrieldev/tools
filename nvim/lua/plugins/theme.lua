return {
  "Tsuzat/NeoSolarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("NeoSolarized").setup({
        transparent = true
      })
      vim.cmd [[ colorscheme NeoSolarized ]]
    end
}
