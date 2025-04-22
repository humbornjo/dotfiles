return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "philosofonusus/ecolog.nvim",
    },
    opts = {
      sources = {
        default = { 'ecolog', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          ecolog = { name = 'ecolog', module = 'ecolog.integrations.cmp.blink_cmp' },
        },
      },
    },
  },
  {
    'philosofonusus/ecolog.nvim',
    lazy = false,
    opts = {
      integrations = { blink_cmp = true, },
      -- Enables shelter mode for sensitive values
      load_shell = {
        enabled = true,   -- Enable shell variable loading
        override = false, -- When false, .env files take precedence over shell variables
        -- Optional: transform shell variables before loading
        transform = function(key, value)
          -- Example: prefix shell variables for clarity
          return "[shell] " .. value
        end
      }
    },
  }
}
