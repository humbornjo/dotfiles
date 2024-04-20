return {
  "nat-418/boole.nvim",
  event = "BufEnter",
  opts = {
    mappings = {
      increment = "<C-d>",
      decrement = "<C-a>",
      -- false
      -- no
      -- 6
    },
    additions = {
      { "prod",   "dev",     "test", "sandbox" },
      { "let",    "const" },
      { "start",  "end" },
      { "before", "after" },
      { "plus",   "minus" },
      { "smart",  "truncate" },
      { "left",   "right" },
      { "is",     "are" },
      { "slow",   "fast" },
      { "create", "remove" },
      { "from",   "to" },
    },
  },
}
