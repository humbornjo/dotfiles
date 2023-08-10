return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = false,
  priority = 1000,
  ---@class CatppuccinOptions
  opts = {
    flavour = "Frappe",
    transparent_background = true,
    integrations = {
      cmp = true,
      neotree = true,
      fidget = true,
      gitsigns = true,
      harpoon = true,
      lsp_trouble = true,
      mason = true,
      noice = true,
      notify = true,
      octo = true,
      telescope = {
        enabled = true,
      },
      overseer = true,
      treesitter = true,
      treesitter_context = true,
      symbols_outline = true,
      illuminate = true,
      which_key = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
    },
  },
}
