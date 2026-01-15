return {
  "lukas-reineke/virt-column.nvim",
  lazy = false,
  keys = {
    -- toggle colorcolumn
    {
      "<Leader>vc",
      function()
        local state = not vim.g.virt_column_enabled
        require("virt-column").update({ enabled = state })
        vim.g.virt_column_enabled = state
        vim.cmd("redraw!")
      end,
      desc = "Toggle colorcolumn",
    },
  },
  opts = {
    enabled = false,
    virtcolumn = "+1,70",
  },
  config = function(_, opts)
    vim.g.virt_column_enabled = false
    require("virt-column").setup(opts)
  end,
}
