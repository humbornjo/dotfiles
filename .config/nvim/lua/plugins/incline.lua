return {
  "b0o/incline.nvim",
  enabled = true,
  lazy = true,
  event = "BufEnter",
  dependencies = { "sainnhe/gruvbox-material" },
  config = function()
    local get_icon = require("astroui").get_icon
    local config = vim.fn["gruvbox_material#get_configuration"]()
    local palette = vim.fn["gruvbox_material#get_palette"](
      config.background, config.foreground, config.colors_override
    )
    local function get_diagnostic_label(props)
      local icons = {
        warn = { icon = get_icon("DiagnosticWarn"), guifg = palette.yellow[1] },
        hint = { icon = get_icon("DiagnosticHint"), guifg = palette.green[1] },
        info = { icon = get_icon("DiagnosticInfo"), guifg = palette.blue[1] },
        error = { icon = get_icon("DiagnosticError"), guifg = palette.red[1] },
      }
      local label = {}
      for severity, icon_info in pairs(icons) do
        local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
        if n > 0 then
          table.insert(label, { icon_info.icon .. " " .. n .. " ", guifg = icon_info.guifg })
        end
      end
      return label
    end

    require("incline").setup({
      hide = {
        only_win = false,
        cursorline = true,
        focused_win = false,
      },
      window = {
        padding = 0,
        margin = { horizontal = 0 },
        placement = {
          vertical = "top",
          horizontal = "right",
        },
      },
      render = function(props)
        local helpers = require("incline.helpers")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)

        local buffer = {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
          or "",
          " ",
          { filename,                   gui = modified },
          " ",
          { get_diagnostic_label(props) },
          guibg = "#282828",
        }
        return buffer
      end,
    })
  end,
}
