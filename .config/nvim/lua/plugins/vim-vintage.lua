return {
  {
    "matze/vim-move",
    enabled = true,
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", mode = { "n", "x" }, "<Plug>(EasyAlign)", desc = "Easy Align" },
    },
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.cmd(
        [[
          let g:VM_check_mappings = 0
          let g:VM_maps = {}
          let g:VM_maps['Add Cursor Down'] = "\x02j"
          let g:VM_maps['Add Cursor Up'] = "\x02k"
        ]]
      )
    end,
    event = "VeryLazy"
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
    event = "VeryLazy",
  }
}
