return {
  "Bekaboo/deadcolumn.nvim",
  enabled = true,
  lazy = false,
  config = function()
    require("deadcolumn").setup({
      scope = "line",
      blending = {
        threshold = 1,
        colorcode = "#282828",
        hlgroup = { "ColorColumn", "bg" },
      },
      warning = {
        alpha = 0.6,
        offset = 40,
        colorcode = "#ea6962",
        hlgroup = { "ErrorMsg", "bg" },
      },
      extra = {
        ---@type string?
        follow_tw = nil,
      },
    })
  end,
}
