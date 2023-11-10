-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("user.utils").list_insert_unique(opts.ensure_installed, {
        "clangd",
        "gopls",
        "pyright",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("user.utils").list_insert_unique(opts.ensure_installed, {
        -- "prettier",
        -- "stylua",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = false,
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("user.utils").list_insert_unique(opts.ensure_installed, {
        "python",
        "codelldb",
        "cppdbg",
      })

      opts.filetypes = {
        ['bash'] = { 'sh' },
	      ['chrome'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	      ['codelldb'] = { 'rust' },
	      ['coreclr'] = { 'cs', 'fsharp' },
	      ['cppdbg'] = { 'c', 'cpp', 'asm', 'swift' },
	      ['dart'] = { 'dart' },
	      ['delve'] = { 'go' },
	      ['firefox'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	      ['kotlin'] = { 'kotlin' },
	      ['mix_task'] = { 'elixir' },
	      ['node2'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	      ['php'] = { 'php' },
	      ['python'] = { 'python' },
	      ['haskell'] = { 'haskell' },
      }

      opts.handlers = {
        cppdbg = function(config)
          config.configurations = {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
              require('rust-tools').runnables.runnables()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            MIMode = "lldb",
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      }
    end,
  },
}
