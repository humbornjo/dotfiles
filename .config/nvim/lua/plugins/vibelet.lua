return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
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
