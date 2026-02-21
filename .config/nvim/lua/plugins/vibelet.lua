return {
  -- {
  --   "coder/claudecode.nvim",
  --   dependencies = { "folke/snacks.nvim" },
  --   config = true,
  --   keys = {
  --     { "<leader>a",  nil,                              desc = "AI/Claude Code" },
  --     { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
  --     { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
  --     { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
  --     { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
  --     { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
  --     { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
  --     { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
  --     {
  --       "<leader>as",
  --       "<cmd>ClaudeCodeTreeAdd<cr>",
  --       desc = "Add file",
  --       ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
  --     },
  --     -- Diff management
  --     { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
  --     { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
  --   },
  -- },
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...) return require('opencode').snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
          terminal = {},
        }
      },
    },
    config = function()
      local opencode = require("opencode")

      vim.g.opencode_opts = {}
      vim.o.autoread = true

      -- Base Group Description (for Which-Key users)
      vim.keymap.set("n", "<leader>a", function() end, { desc = "AI/OpenCode" })

      vim.keymap.set({ "n", "t" }, "<leader>ac", function() opencode.toggle() end, { desc = "Toggle OpenCode" })
      vim.keymap.set({ "n", "t" }, "<leader>as", function() opencode.select() end, { desc = "Resume/Select Session" })
      vim.keymap.set({ "n", "x" }, "<leader>ap", function() opencode.ask("@this ", { submit = false }) end,
        { desc = "Send selection to OpenCode" })

      vim.keymap.set({ "n", "x" }, "<leader>au", function() return require("opencode").operator("@this ") end,
        { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "<leader>ai", function() return require("opencode").operator("@this ") .. "_" end,
        { desc = "Add line to opencode", expr = true })
    end,
  },
  {
    "Exafunction/windsurf.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.g.codeium_no_map_tab = true
      vim.g.codeium_os = 'Darwin'
      vim.g.codeium_arch = 'arm64'
      vim.keymap.set("i", "<M-y>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set("i", "<M-u>", function() return vim.fn["codeium#AcceptNextLine"]() end,
        { expr = true, silent = true })
      vim.keymap.set("i", "<M-i>", function() return vim.fn["codeium#AcceptNextWord"]() end,
        { expr = true, silent = true })
      vim.keymap.set("i", "<M-n>", function() return vim.fn["codeium#CycleCompletions"](1) end,
        { expr = true, silent = true })
      vim.keymap.set("i", "<M-b>", function() return vim.fn["codeium#CycleCompletions"](-1) end,
        { expr = true, silent = true })
      vim.keymap.set("i", "<M-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
    end,
  },
}
