return {
  "sainnhe/gruvbox-material",
  name = "gruvbox-material",
  lazy = false,
  priority = 1500,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_enable_italic = false
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_disable_italic_comment = 1
  end,
}
