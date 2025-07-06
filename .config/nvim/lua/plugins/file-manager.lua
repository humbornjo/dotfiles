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
    "refractalize/oil-git-status.nvim",
    dependencies = {
      "stevearc/oil.nvim",
      ---@module 'oil'
      ---@type oil.SetupOpts
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      opts = {
        keymaps = {
          -- disable default refresh keymap, use <Cmd>e<CR> instead
          ["<C-l>"] = false,
          -- disable default vertical open file keymap
          ["<C-h>"] = false,
        },

        win_options = { signcolumn = "yes:2" },
        view_options = { show_hidden = true },
      },
      init = function()
        vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
      end,
    },

    config = true,
  }
}
