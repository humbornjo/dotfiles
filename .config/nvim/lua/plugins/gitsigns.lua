return {
	"lewis6991/gitsigns.nvim",
	opts = function(_, opts)
		local original_on_attach = opts.on_attach
		opts.on_attach = function(bufnr)
			-- run default on_attach function
			if original_on_attach then
				original_on_attach(bufnr)
			end
			-- continue with customizations such as deleting mappings
			vim.keymap.del("n", "<Leader>gl", { buffer = bufnr })
			vim.keymap.del("n", "<Leader>gL", { buffer = bufnr })
		end
	end,
}
