return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim",
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>yy",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>yw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<leader>yl",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function(_, opts)
      opts.source_selector = {
        winbar = false,
        statusline = false
      }
      require("neo-tree").setup(opts)
    end
  },
  {
    'echasnovski/mini.files',
    version = false,
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
    },
    keys = {
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      -- {
      --   "<leader>fM",
      --   function()
      --     require("mini.files").open(vim.uv.cwd(), true)
      --   end,
      --   desc = "Open mini.files (cwd)",
      -- },
    },
    config = function()
      require('mini.files').setup()
    end
  },
}
