local local_icons = require("config.icons")

local function get_diagnostic_label(props)
  local icons = {
    error = local_icons.DiagnosticError,
    warn = local_icons.DiagnosticWarn,
    info = local_icons.DiagnosticInfo,
    hint = local_icons.DiagnosticHint,
  }
  local label = {}
  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
    if n > 0 then
      table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
    end
  end
  return label
end

local function get_git_diff(props)
  local icons = {
    removed = { icon = local_icons.GitDelete, guifg = "#f38ba8" },
    changed = { icon = local_icons.GitChange, guifg = "#f9e2af" },
    added   = { icon = local_icons.GitAdd   , guifg = "#a6e3a1" },
  }
    -- removed = local_icons.GitDelete,
    -- changed = local_icons.GitChange,
    -- added   = local_icons.GitAdd,
  local labels = {}
  local success, signs = pcall(vim.api.nvim_buf_get_var, props.buf, "gitsigns_status_dict")
  if success then
    for name, icon_info in pairs(icons) do
      if tonumber(signs[name]) and signs[name] > 0 then
        table.insert(labels, { icon_info.icon .. " " .. signs[name] .. " ", guifg = icon_info.guifg }) -- group = "Diff" .. name, 
      end
    end
    return labels
  else
    for name, icon in pairs(icons) do
      if tonumber(signs[name]) and signs[name] > 0 then
        table.insert(labels, { icon .. " " .. signs[name] .. " ", group = "Diff" .. name, guifg = "yellow" })
      end
    end
    return labels
  end
end

return {
  "b0o/incline.nvim",
  enabled = true,
  event = "BufEnter",
  config = function()
    require("incline").setup({
      hide = {
        cursorline = true,
        focused_win = false,
        only_win = false,
      },
      window = {
        -- margin = {
        --   horizontal = 1,
        --   vertical = 2,
        -- },
        placement = {
          horizontal = "right",
          vertical = "top",
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"

        local buffer = {
          { get_git_diff(props) },
          { get_diagnostic_label(props) },
          { ft_icon, guifg = ft_color,},
          { " " },
          { filename, gui = modified },
        }
        return buffer
      end,
    })
  end,
}
