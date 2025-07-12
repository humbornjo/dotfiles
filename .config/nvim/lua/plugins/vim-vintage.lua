return {
  {
    "matze/vim-move",
    enabled = true,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "dhruvasagar/vim-zoom",
    keys = {
      -- press Command+Z to toggle maximum panel in nvim
      -- ["\x02z"] = { "<Plug>(zoom-toggle)" },
      { "\x02z", "<Plug>(zoom-toggle)", mode = { "n", "t", "i" }, desc = "Toggle Zoom Panel" },
    }
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", mode = { "n", "x" }, "<Plug>(EasyAlign)", desc = "Easy Align" },
    },
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
    event = "VeryLazy",
  }
}
