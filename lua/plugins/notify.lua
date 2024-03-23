---@diagnostic disable: missing-fields
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require "notify"
    notify.setup { background_color = "#000000" }
    vim.notify = notify.notify
  end,
}
