return {
	{
		"pmizio/typescript-tools.nvim",
		main = "typescript-tools",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		opts = {},
		config = function(_, opts)
			require("typescript-tools").setup(opts)
		end,
	},
	{
		"AstroNvim/astrolsp",
		---@type AstroLSPOpts
		opts = {
			servers = { "ts_ls" },
			config = {
				ts_ls = {
					init_options = {
						tsserver = { path = "tsserver" },
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vim.fn.stdpath("data")
									.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
								languages = { "vue" },
							},
						},
					},
					filetypes = { "vue" },
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			-- ts_ls is still used for Vue files.
			ensure_installed = { "typescript-language-server" },
		},
	},
}
