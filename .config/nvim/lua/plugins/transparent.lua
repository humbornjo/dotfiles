return {
  "xiyaowong/transparent.nvim",
  dependencies = { "rebelot/heirline.nvim" },
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
        'TabLine', 'TabLineFill', 'WinBar', 'WinBarNC', -- 'TabLineSel',
        'GitSignsAdd', 'GitSignsChange', 'GitSignsDelete',
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
