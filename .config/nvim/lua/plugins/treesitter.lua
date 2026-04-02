return {
	{
		"AstroNvim/astrocore",
		---@type AstroCoreOpts
		opts = {
			treesitter = {
				ensure_installed = {
					"c",
					"go",
					"rust",
					"lua",
					"vim",
					"python",
					"javascript",
					"typescript",
					"vue",
					"markdown",
					"markdown_inline",
					"dockerfile",
				},
				highlight = true,
			},
		},
	},
	{
		"Wansmer/treesj",
		keys = {
			{ "<leader>j", "<cmd>TSJToggle<CR>", desc = "Toggle treesj" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				max_join_length = 180,
				use_default_keymaps = false,
			})
		end,
	},
}
