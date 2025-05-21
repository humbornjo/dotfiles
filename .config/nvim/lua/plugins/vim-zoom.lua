return {
  "dhruvasagar/vim-zoom",
  keys = {
    -- press Command+Z to toggle maximum panel in nvim
    -- ["\x02z"] = { "<Plug>(zoom-toggle)" },
    { "\x02z", "<Plug>(zoom-toggle)", mode = { "n", "t", "i" }, desc = "Toggle Zoom Panel" },
  }
}
