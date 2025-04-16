return {
  "roobert/search-replace.nvim",

  keys = {
    { "<C-r>",       "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", mode = "v", desc = "Search/Replace Single Buffer Visual", },
    { "<C-s>",       "<CMD>SearchReplaceWithinVisualSelection<CR>",       mode = "v", desc = "Search/Replace Within Visual", },
    { "<C-b>",       "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>",  mode = "v", desc = "Search/Replace Within Visual CWord" },

    { "<leader>rs",  "<CMD>SearchReplaceSingleBufferSelections<CR>",      mode = "n", desc = "Search/Replace Single Buffer Selections", },
    { "<leader>ro",  "<CMD>SearchReplaceSingleBufferOpen<CR>",            mode = "n", desc = "Search/Replace Single Buffer Open", },
    { "<leader>rw",  "<CMD>SearchReplaceSingleBufferCWord<CR>",           mode = "n", desc = "Search/Replace Single Buffer CWord" },
    { "<leader>rW",  "<CMD>SearchReplaceSingleBufferCWORD<CR>",           mode = "n", desc = "Search/Replace Single Buffer CWORD" },
    { "<leader>re",  "<CMD>SearchReplaceSingleBufferCExpr<CR>",           mode = "n", desc = "Search/Replace Single Buffer CExpr" },
    { "<leader>rf",  "<CMD>SearchReplaceSingleBufferCFile<CR>",           mode = "n", desc = "Search/Replace Single Buffer CFile" },

    { "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>",       mode = "n", desc = "Search/Replace Multi Buffer Selections", },
    { "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>",             mode = "n", desc = "Search/Replace Multi Buffer Open", },
    { "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>",            mode = "n", desc = "Search/Replace Multi Buffer CWord", },
    { "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>",            mode = "n", desc = "Search/Replace Multi Buffer CWORD", },
    { "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>",            mode = "n", desc = "Search/Replace Multi Buffer CExpr", },
    { "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>",            mode = "n", desc = "Search/Replace Multi Buffer CFile", },
  },
  config = function()
    require("search-replace").setup({
      -- optionally override defaults
      default_replace_single_buffer_options = "gcI",
      default_replace_multi_buffer_options = "egcI",
    })
  end,
}
