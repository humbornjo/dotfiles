return {
  { "jose-elias-alvarez/typescript.nvim", lazy = true }, -- add lsp plugin
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      setup_handlers = {
        -- add custom handler
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
        end,
      },
    },
    config = function(_, opts)
      opts.config.ts_ls = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vim.fn.expand("$MASON/packages/vue-language-server") ..
                  '/node_modules/@vue/language-server',
              languages = { "vue" },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      }
      require("astrolsp").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "typescript-language-server" }, -- automatically install lsp
    },
  },
}
