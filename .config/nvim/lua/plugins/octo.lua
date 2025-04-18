return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("octo").setup({
			enable_builtin = true,
			mappings = {
				review_diff = {
					select_next_entry = { lhs = "<Tab>", desc = "move to previous changed file" },
					select_prev_entry = { lhs = "<S-Tab>", desc = "move to next changed file" },
				},
			},
		})
		vim.treesitter.language.register("markdown", "octo")
	end,
	keys = {
		{ "<leader>O", "<cmd>Octo<cr>", desc = "Octo" },
	},
}
