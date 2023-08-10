return {
  "Wansmer/treesj",
  keys = {
    {"<leader>m", "<cmd>TSJToggle<CR>", desc = "Treesj toggle"},
    {"<leader>j", "<cmd>TSJSplit<CR>", desc = "Treesj split"},
    {"<leader>s", "<cmd>TSJJoin<CR>", desc = "Treesj join"}
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({})
  end,
}
