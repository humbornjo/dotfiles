return {
	"Wansmer/treesj",
	keys = {
		{ "<leader>j", "<cmd>TSJToggle<CR>", desc = "Toggle treesj" },
		-- { "<leader>j", "<cmd>TSJSplit<CR>", desc = "Treesj split" },
		-- { "<leader>s", "<cmd>TSJJoin<CR>", desc = "Treesj join" },
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			max_join_length = 180,
			use_default_keymaps = false
		})
	end,
}
