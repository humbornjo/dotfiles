return {
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
    init = function()
      local data_path = vim.fn.stdpath("data")

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
    end,
  },
  {
    "matze/vim-move",
    enabled = true,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "dhruvasagar/vim-zoom",
    keys = {
      -- press Command+Z to toggle maximum panel in nvim
      -- ["\x02z"] = { "<Plug>(zoom-toggle)" },
      { "\x02z", "<Plug>(zoom-toggle)", mode = { "n", "t", "i" }, desc = "Toggle Zoom Panel" },
    }
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", mode = { "n", "x" }, "<Plug>(EasyAlign)", desc = "Easy Align" },
    },
  }
}
