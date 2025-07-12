return {
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

    config = function()
      local glyphs = {
        ["!"] = " ",
        ["?"] = " ",
        ["A"] = " ",
        ["C"] = " ",
        ["D"] = " ",
        ["M"] = " ",
        ["R"] = " ",
        ["T"] = "󱁥 ",
        ["U"] = "󰾋 ",
        [" "] = "  ",
      }
      require('oil-git-status').setup({
        show_ignored = true, -- show files that match gitignore with !!
        symbols = {          -- customize the symbols that appear in the git status columns
          index = glyphs,
          working_tree = glyphs,
        },
      })
    end,
  }
}
