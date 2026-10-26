-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
	"AstroNvim/astrolsp",
	dependencies = { "williamboman/mason.nvim" },
	init = function()
		if vim.g.clwrap_format_wrapped then return end
		vim.g.clwrap_format_wrapped = true
		local filetypes = {
			go = "go",
			typescript = "typescript",
			typescriptreact = "tsx",
			rust = "rust",
			zig = "zig",
		}
		local extensions = {
			go = "go",
			ts = "typescript",
			mts = "typescript",
			cts = "typescript",
			tsx = "tsx",
			rs = "rust",
			zig = "zig",
		}

		-- AstroNvim's manual and save formatting both call vim.lsp.buf.format.
		local lsp_format = vim.lsp.buf.format
		vim.lsp.buf.format = function(opts)
			local result = lsp_format(opts)
			local bufnr = opts and opts.bufnr or vim.api.nvim_get_current_buf()
			if bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
			if not vim.api.nvim_buf_is_valid(bufnr) then return result end

			local extension = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":e"):lower()
			local language = extensions[extension] or filetypes[vim.bo[bufnr].filetype]
			local clwrap = vim.fn.exepath("clwrap")
			if not language or clwrap == "" then return result end

			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local input = table.concat(lines, "\n") .. (vim.bo[bufnr].endofline and "\n" or "")
			local output = vim.system({ clwrap, "--lang", language, "-" }, { stdin = input, text = true }):wait()
			if output.code ~= 0 or type(output.stdout) ~= "string" or output.stdout == input then return result end

			local view = bufnr == vim.api.nvim_get_current_buf() and vim.fn.winsaveview() or nil
			local text = output.stdout
			local endofline = text:sub(-1) == "\n"
			if endofline then text = text:sub(1, -2) end
			vim.bo[bufnr].endofline = endofline
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(text, "\n", { plain = true }))
			if view then vim.fn.winrestview(view) end
			return result
		end
	end,
	---@type AstroLSPOpts
	opts = {
		-- Configuration table of features provided by AstroLSP
		features = {
			codelens = false, -- enable/disable codelens refresh on start
			inlay_hints = false, -- enable/disable inlay hints on start
			semantic_tokens = true, -- enable/disable semantic token highlighting
		},
		-- customize lsp formatting options
		formatting = { format_on_save = { enabled = true }, disabled = {} },
		-- enable servers that you already have installed without mason
		servers = {},
		on_attach = nil,
		---@diagnostic disable: missing-fields
		config = { ["*"] = { capabilities = vim.lsp.protocol.make_client_capabilities() } },
		-- Configure buffer local auto commands to add when attaching a language server
		autocmds = {
			-- first key is the `augroup` to add the auto commands to (:h augroup)
			lsp_codelens_refresh = {
				-- Optional condition to create/delete auto command group
				-- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
				-- condition will be resolved for each client on each execution and if it ever fails for all clients,
				-- the auto commands will be deleted for that buffer
				cond = "textDocument/codeLens",
				-- cond = function(client, bufnr) return client.name == "lua_ls" end,
				-- list of auto commands to set
				{
					-- events to trigger
					event = { "InsertLeave", "BufEnter" },
					-- the rest of the autocmd options (:h nvim_create_autocmd)
					desc = "Refresh codelens (buffer)",
					callback = function(args)
						if require("astrolsp").config.features.codelens then
							vim.lsp.codelens.refresh({ bufnr = args.buf })
						end
					end,
				},
			},
		},
		-- mappings to be set up on attaching of a language server
		mappings = {
			n = {
				-- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
				gD = {
					function()
						vim.lsp.buf.declaration()
					end,
					desc = "Declaration of current symbol",
					cond = "textDocument/declaration",
				},
				gA = {
					function()
						vim.lsp.buf.code_action()
					end,
					desc = "vim.lsp.buf.code_action()",
				},
				["<Leader>uY"] = {
					function()
						require("astrolsp.toggles").buffer_semantic_tokens()
					end,
					desc = "Toggle LSP semantic highlight (buffer)",
					cond = function(client)
						return client.supports_method("textDocument/semanticTokens/full") and vim.lsp.semantic_tokens ~= nil
					end,
				},
			},
			x = {
				gA = {
					function()
						vim.lsp.buf.code_action()
					end,
					desc = "vim.lsp.buf.code_action()",
				},
			},
		},
	},
}
