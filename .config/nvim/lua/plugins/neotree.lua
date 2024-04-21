return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  opts = {
    enable_opened_markers = false,
    enable_diagnostics = true,
    enable_git_status = true,
    source_selector = {
      padding = { left = 1, right = 0 },
      content_layout = "start",
      separator = { left = "", right= "" },
    },
    window = {
      width = 26,
    },
  },
}
