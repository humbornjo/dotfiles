return {
  "AckslD/nvim-neoclip.lua",
  requires = {
    -- you'll need at least one of these
    { 'nvim-telescope/telescope.nvim' },
    -- {'ibhagwan/fzf-lua'},
  },
  config = function()
    require('neoclip').setup()
  end,
  keys = {
    { "<leader>fy", "<cmd>Telescope neoclip<CR>", desc = "Telescope neoclip" },
  },
}
