return {
  'f4z3r/gruvbox-material.nvim',
  name = 'gruvbox-material',
  lazy = false,
  priority = 1000,
  opts = {
    italics = true,    -- enable italics in general
    contrast = "hard", -- set contrast, can be any of "hard", "medium", "soft"
    comments = {
      italics = true,  -- enable italic comments
    },
    background = {
      transparent = true, -- set the background to transparent
    },
    float = {
      force_background = true, -- force background on floats even when background.transparent is set
      background_color = nil,  -- set color for float backgrounds. If nil, uses the default color set
      -- by the color scheme
    },
    signs = {
      highlight = false, -- whether to highlight signs
    },
  },
}
