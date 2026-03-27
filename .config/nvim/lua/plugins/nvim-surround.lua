return {
  "kylechui/nvim-surround",
  version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",

  config = function()
    vim.keymap.set("n", "ym", "<Plug>(nvim-surround-normal)", {
      desc = "Add a surrounding pair around a motion (normal mode)",
    })
    vim.keymap.set("n", "ymm", "<Plug>(nvim-surround-normal-cur)", {
      desc = "Add a surrounding pair around the current line (normal mode)",
    })
    vim.keymap.set("n", "yM", "<Plug>(nvim-surround-normal-line)", {
      desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
    })
    vim.keymap.set("n", "yMM", "<Plug>(nvim-surround-normal-cur-line)", {
      desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
    })
    vim.keymap.set("x", "M", "<Plug>(nvim-surround-visual)", {
      desc = "Add a surrounding pair around a visual selection",
    })
    vim.keymap.set("x", "gM", "<Plug>(nvim-surround-visual-line)", {
      desc = "Add a surrounding pair around a visual selection, on new lines",
    })
    vim.keymap.set("n", "dm", "<Plug>(nvim-surround-delete)", {
      desc = "Delete a surrounding pair",
    })
    vim.keymap.set("n", "cm", "<Plug>(nvim-surround-change)", {
      desc = "Change a surrounding pair",
    })
    vim.keymap.set("n", "cM", "<Plug>(nvim-surround-change-line)", {
      desc = "Change a surrounding pair, putting replacements on new lines",

    })
  end

}
