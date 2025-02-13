local ui_utils = require("plugins.utils.ui")

local commands = {
  ToggleTranparency = function ()
    ui_utils.toggle_transparency()
  end
}

for command, fun in pairs(commands) do
  vim.api.nvim_create_user_command(command, fun, {})
end
