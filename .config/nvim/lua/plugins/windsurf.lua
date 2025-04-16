return {
	"Exafunction/windsurf.vim",
	config = function()
		-- Change '<C-g>' here to any keycode you like.
		vim.g.codeium_no_map_tab = true
		vim.g.codeium_os = 'Darwin'
		vim.g.codeium_arch = 'arm64'
		vim.keymap.set("i", "<M-y>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
		vim.keymap.set("i", "<M-u>", function() return vim.fn["codeium#AcceptNextWord"]() end, { expr = true, silent = true })
		vim.keymap.set("i", "<M-n>", function() return vim.fn["codeium#CycleCompletions"](1) end,
			{ expr = true, silent = true })
		vim.keymap.set("i", "<M-b>", function() return vim.fn["codeium#CycleCompletions"](-1) end,
			{ expr = true, silent = true })
		vim.keymap.set("i", "<M-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
	end,
}
