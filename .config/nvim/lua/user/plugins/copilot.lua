return {
  "zbirenbaum/copilot.lua",
  lazy = false,
  cmd = "Copilot",
  opts = {
    suggestion = { enabled = true },
    panel = { enabled = true },
    filetypes = {
      help = true,
      javascript = true,
      python = true,
      go = true,
      lua = true,
      markdown = true,
      typescript = true,
    },
  },
}
