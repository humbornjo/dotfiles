return {
  {
    'ruifm/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("gitlinker").setup({
        callbacks = {
          ["github.com"] = require "gitlinker.hosts".get_github_type_url,
          ["gitlab.com"] = require "gitlinker.hosts".get_gitlab_type_url,
          ["dev.msh.team"] = require "gitlinker.hosts".get_gitlab_type_url,
          ["try.gitea.io"] = require "gitlinker.hosts".get_gitea_type_url,
          ["codeberg.org"] = require "gitlinker.hosts".get_gitea_type_url,
          ["bitbucket.org"] = require "gitlinker.hosts".get_bitbucket_type_url,
          ["try.gogs.io"] = require "gitlinker.hosts".get_gogs_type_url,
          ["git.sr.ht"] = require "gitlinker.hosts".get_srht_type_url,
          ["git.launchpad.net"] = require "gitlinker.hosts".get_launchpad_type_url,
          ["repo.or.cz"] = require "gitlinker.hosts".get_repoorcz_type_url,
          ["git.kernel.org"] = require "gitlinker.hosts".get_cgit_type_url,
          ["git.savannah.gnu.org"] = require "gitlinker.hosts".get_cgit_type_url
        },
      })
    end
  },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    keys = {
      { "<leader>gB", mode = { "n" }, "<cmd>BlameToggle virtual<cr>", desc = "Toggle blame virtual" },
      { "<leader>gL", mode = { "n" }, "<cmd>BlameToggle window<cr>",  desc = "Toggle blame window" },
    },
    config = function()
      require("blame").setup({
        date_format = "%Y.%m.%d",
        virtual_style = "right_align",
        views = {},
        focus_blame = true,
        merge_consecutive = false,
        max_summary_width = 30,
        colors = {
          "#f5e0dc",
          "#f2cdcd",
          "#f5c2e7",
          "#cba6f7",
          "#f38ba8",
          "#eba0ac",
          "#fab387",
          "#f9e2af",
          "#a6e3a1",
          "#94e2d5",
          "#89dceb",
          "#74c7ec",
          "#89b4fa",
          "#b4befe",
          "#cdd6f4",
        },
        blame_options = nil,
        commit_detail_view = "vsplit",
        format_fn = require("blame.formats.default_formats").commit_date_author_fn,
        mappings = {
          commit_info = "i",
          stack_push = "<TAB>",
          stack_pop = "<BS>",
          show_commit = "<CR>",
          close = { "<esc>", "q" },
        },
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    enabled = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local original_on_attach = opts.on_attach
      opts.on_attach = function(bufnr)
        -- run default on_attach function
        if original_on_attach then
          original_on_attach(bufnr)
        end
        -- continue with customizations such as deleting mappings
        vim.keymap.del("n", "<Leader>gL", { buffer = bufnr })
      end
    end,
  },
}
