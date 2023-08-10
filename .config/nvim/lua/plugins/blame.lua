return {
  "FabijanZulj/blame.nvim",
  lazy = false,
  keys = {
    { "<leader>gl", "<cmd>BlameToggle virtual<cr>", desc = "Toggle blame virtual" },
    { "<leader>gL", "<cmd>BlameToggle window<cr>",  desc = "Toggle blame window" },
  },
  config = function()
    require("blame").setup {
      date_format = "%Y.%m.%d",
      virtual_style = "right_align",
      views = {},
      focus_blame = true,
      merge_consecutive = false,
      max_summary_width = 30,
      colors = nil,
      blame_options = nil,
      commit_detail_view = "vsplit",
      format_fn = require("blame.formats.default_formats").date_message,
      mappings = {
        commit_info = "i",
        stack_push = "<TAB>",
        stack_pop = "<BS>",
        show_commit = "<CR>",
        close = { "<esc>", "q" },
      }
    }
  end,
}
