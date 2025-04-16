return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	opts = {
		view_options = { show_hidden = true },
	},
	init = function()
		vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
	end,
}
