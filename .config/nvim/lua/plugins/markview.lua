return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  -- For blink.cmp's completion
  -- source
  dependencies = {
    "saghen/blink.cmp"
  },
  keys = {
    { "<leader>m", "<cmd>Markview toggle<cr>", desc = "Toggle markview" }
  },
  opts = {
    experimental = { check_rtp_message = false },
  },
  config = function(_, opts)
    require("markview").setup(opts)
    vim.api.nvim_create_autocmd("User", {
      pattern = "MarkviewAttach",
      callback = function(_)
        vim.cmd("Markview enable")
      end
    })
  end,
};
