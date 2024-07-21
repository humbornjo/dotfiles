-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

local colors = require("gruvbox-material.colors").get(vim.o.background, "hard")
require('gruvbox-material').setup({
  italics = true,    -- enable italics in general
  contrast = "hard", -- set contrast, can be any of "hard", "medium", "soft"
  comments = {
    italics = true,  -- enable italic comments
  },
  background = {
    transparent = true, -- set the background to transparent
  },
  float = {
    force_background = false,     -- force background on floats even when background.transparent is set
    background_color = "#1d2021", -- set color for float backgrounds. If nil, uses the default color set
    -- by the color scheme
  },
  customize = nil,
})
