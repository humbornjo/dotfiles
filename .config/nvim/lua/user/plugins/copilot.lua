return {
  "zbirenbaum/copilot.lua",
  lazy = false,
  cmd = "Copilot",
  opts = {
    suggestion = { 
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<M-CR>",
        accept_word = "<M-Right>",
        accept_line =  "<M-Down>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    panel = { 
      enabled = true,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-p>"
      },
    },
    filetypes = {
      help = true,
      javascript = true,
      python = true,
      go = true,
      lua = true,
      markdown = true,
      typescript = true,
      rust = true,
    },
  },
}
