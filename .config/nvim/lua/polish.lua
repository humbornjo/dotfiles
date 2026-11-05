-- center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { silent = true, desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Half page up (centered)" })

vim.keymap.set("n", "yY", function()
	local view = vim.fn.winsaveview()
	vim.cmd([[keepjumps keepmarks normal! ggVG"+y]])
	vim.fn.winrestview(view)
end, { silent = true, desc = "Yank entire buffer to system clipboard" })

vim.keymap.set("n", "<leader>vl", function()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		vim.notify("Current buffer has no file path", vim.log.levels.WARN)
		return
	end

	local root = vim.fs.root(path, ".git")
	local relative_path = root and vim.fs.relpath(root, path) or path
	local location = relative_path .. ":" .. vim.fn.line(".")
	vim.fn.setreg("+", location)
	vim.notify("Copied " .. location)
end, { desc = "Copy git-relative file:line to clipboard" })

vim.keymap.set("n", "<leader>vL", function()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		vim.notify("Current buffer has no file path", vim.log.levels.WARN)
		return
	end

	local location = path .. ":" .. vim.fn.line(".")
	vim.fn.setreg("+", location)
	vim.notify("Copied " .. location)
end, { desc = "Copy absolute file:line to clipboard" })

vim.keymap.set("x", "<leader>vb", function()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		vim.notify("Current buffer has no file path", vim.log.levels.WARN)
		return
	end

	local root = vim.fs.root(path, ".git")
	local relative_path = root and vim.fs.relpath(root, path) or path
	local first_line = vim.fn.line("v")
	local last_line = vim.fn.line(".")
	if first_line > last_line then
		first_line, last_line = last_line, first_line
	end

	local location = string.format("%s:%d-%d", relative_path, first_line, last_line)
	vim.fn.setreg("+", location)
	vim.notify("Copied " .. location)
end, { desc = "Copy git-relative file:line range to clipboard" })

vim.keymap.set("x", "<leader>vB", function()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		vim.notify("Current buffer has no file path", vim.log.levels.WARN)
		return
	end

	local first_line = vim.fn.line("v")
	local last_line = vim.fn.line(".")
	if first_line > last_line then
		first_line, last_line = last_line, first_line
	end

	local location = string.format("%s:%d-%d", path, first_line, last_line)
	vim.fn.setreg("+", location)
	vim.notify("Copied " .. location)
end, { desc = "Copy absolute file:line range to clipboard" })

local function google(query)
	vim.ui.open("https://google.com/search?q=" .. vim.uri_encode(query, "rfc2396"))
end

vim.keymap.set("n", "g?", function()
	google(vim.fn.expand("<cword>"))
end, { desc = "Google search word under cursor" })

vim.keymap.set("x", "g?", function()
	local region = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })
	google(vim.trim(table.concat(region, " ")))
	vim.api.nvim_input("<Esc>")
end, { desc = "Google search selected text" })
