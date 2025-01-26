return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  ---@class NoiceConfig
  opts = {
    ---@type NoicePresets
    presets = {
      inc_rename = true,
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    ---@type NoiceConfigViews
    views = {
      cmdline_popup = {
        position = {
          row = 7,
          col = "55%",
        },
      },
      cmdline_popupmenu = {
        position = {
          row = 7,
          col = "55%",
        },
      },
    },
  },
}
