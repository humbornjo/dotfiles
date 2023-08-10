return function(_, opts)
  require("mason-lspconfig").setup(opts)
  require("user.utils").event "MasonLspSetup"
end
