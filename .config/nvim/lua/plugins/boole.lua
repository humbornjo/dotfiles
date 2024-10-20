return {
  "nat-418/boole.nvim",
  event = "BufEnter",
  opts = {
    mappings = {
      increment = "<A-=>",
      decrement = "<A-->",
      -- false
      -- no
      -- 8
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
