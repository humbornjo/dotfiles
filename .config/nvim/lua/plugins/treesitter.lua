-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "c", "go", "rust",
      "lua", "vim", "python",
      "javascript", "typescript", "vue",
      "markdown", "markdown_inline", "dockerfile",
    },
  },
}
