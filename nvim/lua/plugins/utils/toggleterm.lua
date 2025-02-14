return {
  open_new_terminal = function()
    vim.ui.select(
      { "horizontal", "float" },
      {
        prompt = "New terminal direction"
      },
      function(choise)
        if choise then
          require('toggleterm.terminal').Terminal:new({
            hidden = false,
            direction = choise
          }):open()
        end
      end
    )
  end
}
