return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
  },
  keys = {
    {
      "<leader>cn",
      function ()
        require("notify").dismiss()
      end
    }
  }
}
