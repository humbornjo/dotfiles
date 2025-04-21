return {
  "xiyaowong/transparent.nvim",
  config = function()
    vim.g.transparent_enabled = true
    require("transparent").setup({
      -- table: default groups
      groups = {
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
        'EndOfBuffer',
      },
      -- table: additional groups that should be cleared
      extra_groups = {
        'FloatBorder', 'FloatTitle',
        'NormalFloat', 'FoldColumn',
        'LspInfoBorder', 'DiagnosticSignWarn',
        'GitSignsAdd', 'GitSignsChange', 'GitSignsDelete',
        'TabLineSel', 'TabLine', 'TabLineFill', 'WinBar', 'WinBarNC',
        'NeoTreeNormal', 'NeoTreeNormalNC', 'NeoTreePreview', 'NeoTreeTabInactive',
      },
      -- table: groups you don't want to clear
      exclude_groups = {},
      -- function: code to be executed after highlight groups are cleared
      -- Also the user event "TransparentClear" will be triggered
      on_clear = function() end,
    })
  end,
}
