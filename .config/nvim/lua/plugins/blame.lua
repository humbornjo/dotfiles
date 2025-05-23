return {
	"FabijanZulj/blame.nvim",
	lazy = false,
	keys = {
		{ "<leader>gB", mode = { "n" }, "<cmd>BlameToggle virtual<cr>", desc = "Toggle blame virtual" },
		{ "<leader>gL", mode = { "n" }, "<cmd>BlameToggle window<cr>",  desc = "Toggle blame window" },
	},
	config = function()
		require("blame").setup({
			date_format = "%Y.%m.%d",
			virtual_style = "right_align",
			views = {},
			focus_blame = true,
			merge_consecutive = false,
			max_summary_width = 30,
			colors = {
				"#f5e0dc",
				"#f2cdcd",
				"#f5c2e7",
				"#cba6f7",
				"#f38ba8",
				"#eba0ac",
				"#fab387",
				"#f9e2af",
				"#a6e3a1",
				"#94e2d5",
				"#89dceb",
				"#74c7ec",
				"#89b4fa",
				"#b4befe",
				"#cdd6f4",
			},
			blame_options = nil,
			commit_detail_view = "vsplit",
			format_fn = require("blame.formats.default_formats").commit_date_author_fn,
			mappings = {
				commit_info = "i",
				stack_push = "<TAB>",
				stack_pop = "<BS>",
				show_commit = "<CR>",
				close = { "<esc>", "q" },
			},
		})
	end,
}
