return {
  "sainnhe/gruvbox-material",
  name = "gruvbox-material",
  commit = "cf4709418b4066aee67d9c0bfaa1b0d631ce68a5",
  lazy = false,
  priority = 1500,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_ui_contrast = "high"
    vim.g.gruvbox_material_enable_italic = false
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_disable_italic_comment = 1
  end,
}
