-- Customize Mason

---@type LazySpec
return {
	-- use mason-tool-installer for automatically installing Mason packages
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- overrides `require("mason-tool-installer").setup(...)`
		opts = {
			-- Make sure to use the names found in `:Mason`
			ensure_installed = {
				-- install language servers
				"buf",
				"gopls",
				"clangd",
				"helm-ls",
				"pyright",
				"rust-analyzer",
				"lua-language-server",
				"vue-language-server",
				"yaml-language-server",
				"astro-language-server",
				"typescript-language-server",
				"dockerfile-language-server",

				-- install linters
				"sqlfluff",
				"golangci-lint",

				-- install formatters
				"black",
				"stylua",
				"prettierd",

				-- install debuggers
				"delve",
				"debugpy",
				"codelldb",

				-- install any other package
				"tree-sitter-cli",
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		enabled = false,
		dependencies = { "williamboman/mason.nvim", },
		linters_by_ft = {
			go = { "golangcilint" },
		},
	},
	{
		"towolf/vim-helm",
		ft = 'helm'
	}
}
