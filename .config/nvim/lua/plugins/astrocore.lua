-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
	"AstroNvim/astrocore",
	---@type AstroCoreOpts
	opts = {
		-- Configure core features of AstroNvim
		features = {
			large_buf = { size = 1024 * 256, lines = 10000 },           -- set global limits for large files for disabling features like treesitter
			autopairs = true,                                           -- enable autopairs at start
			cmp = true,                                                 -- enable completion at start
			diagnostics = { virtual_text = false, virtual_lines = false }, -- diagnostic settings on startup
			highlighturl = true,                                        -- highlight URLs at start
			notifications = true,                                       -- enable notifications at start
		},
		-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
		diagnostics = {
			virtual_text = true,
			underline = true,
		},
		-- passed to `vim.filetype.add`
		filetypes = {
			-- see `:h vim.filetype.add` for usage
			extension = { foo = "fooscript", },
			filename = { [".foorc"] = "fooscript" },
			pattern = { [".*/etc/foo/.*"] = "fooscript" },
		},
		-- vim options can be configured here
		options = {
			opt = {              -- vim.opt.<key>
				relativenumber = true, -- sets vim.opt.relativenumber
				number = true,     -- sets vim.opt.number
				spell = false,     -- sets vim.opt.spell
				signcolumn = "yes", -- sets vim.opt.signcolumn to yes
				wrap = true,       -- sets vim.opt.wrap
			},
			g = {                -- vim.g.<key>
				-- configure global vim variables (vim.g)
				-- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
				-- This can be found in the `lua/lazy_setup.lua` file
			},
		},
		-- Mappings can be configured through AstroCore as well.
		-- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
		mappings = {
			-- first key is the mode
			n = {
				-- second key is the lefthand side of the map

				-- navigate buffer tabs with `H` and `L`
				["L"] = { function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" },
				["H"] = { function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Previous buffer" },

				-- press Command+Z to toggle maximum panel in nvim
				["\x02z"] = { "<Plug>(zoom-toggle)" },

				-- toggle colorcolumn
				["<Leader>be"] = {
					function()
						if vim.o.colorcolumn ~= "" then
							vim.o.colorcolumn = ""
						else
							vim.o.colorcolumn = "80"
						end
					end,
					desc = "Toggle colorcolumn",
				},

				-- mappings seen under group name "Buffer"
				["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "new tab" },
				["<Leader>bD"] = {
					function()
						require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
					end,
					desc = "Pick to close",
				},
				-- tables with just a `desc` key will be registered with which-key if it's installed
				-- this is useful for naming menus
				["<leader>b"] = { name = "buffers", desc = " Buffers" },
				-- quick save
				-- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
				["<A-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
				["<A-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
				["<A-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
				["<A-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },

				-- tables with just a `desc` key will be registered with which-key if it's installed
				-- this is useful for naming menus
				-- ["<Leader>b"] = { desc = "Buffers" },

				-- setting a mapping to false will disable it
				-- ["<C-S>"] = false,
			},
			i = {
				-- jump by word
				["<C-j>"] = { "<Down>" },
				["<C-k>"] = { "<Up>" },
				["<C-h>"] = { "<C-o>b" },
				["<C-l>"] = { "<C-o>w" },

				-- once upon a time
				["<C-e>"] = { "<C-o>A" },
				["<C-a>"] = { "<C-o>I" },

				-- delete by word
				["<C-w>"] = { "<C-w>" },
				["<C-s>"] = { "<C-o>dw" },

				-- delete by letter
				["<A-w>"] = { "<BS>" },
				["<A-s>"] = { "<Del>" },
			},
		},
	},
}
