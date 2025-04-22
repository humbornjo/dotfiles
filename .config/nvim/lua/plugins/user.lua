-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

	-- == Examples of Adding Plugins ==

	"andweeb/presence.nvim",
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function() require("lsp_signature").setup() end,
	},

	-- == Examples of Overriding Plugins ==

	-- customize dashboard options
	{
		"folke/snacks.nvim",
		keys = {
			-- Grep
			{ "<leader>sb", function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
			{ "<leader>sB", function() Snacks.picker.grep_buffers() end,          desc = "Grep Open Buffers" },
			{ "<leader>sg", function() Snacks.picker.grep() end,                  desc = "Grep" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },
			-- search
			{ '<leader>s"', function() Snacks.picker.registers() end,             desc = "Registers" },
			{ "<leader>s/", function() Snacks.picker.search_history() end,        desc = "Search History" },
			{ "<leader>sa", function() Snacks.picker.autocmds() end,              desc = "Autocmds" },
			{ "<leader>sb", function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
			{ "<leader>sc", function() Snacks.picker.command_history() end,       desc = "Command History" },
			{ "<leader>sC", function() Snacks.picker.commands() end,              desc = "Commands" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
			{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
			{ "<leader>sh", function() Snacks.picker.help() end,                  desc = "Help Pages" },
			{ "<leader>sH", function() Snacks.picker.highlights() end,            desc = "Highlights" },
			{ "<leader>si", function() Snacks.picker.icons() end,                 desc = "Icons" },
			{ "<leader>sj", function() Snacks.picker.jumps() end,                 desc = "Jumps" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
			{ "<leader>sl", function() Snacks.picker.loclist() end,               desc = "Location List" },
			{ "<leader>sm", function() Snacks.picker.marks() end,                 desc = "Marks" },
			{ "<leader>sM", function() Snacks.picker.man() end,                   desc = "Man Pages" },
			{ "<leader>sp", function() Snacks.picker.lazy() end,                  desc = "Search for Plugin Spec" },
			{ "<leader>sq", function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
			{ "<leader>sR", function() Snacks.picker.resume() end,                desc = "Resume" },
			{ "<leader>su", function() Snacks.picker.undo() end,                  desc = "Undo History" },
			-- LSP
			{ "ga",         function() vim.lsp.buf.code_action() end,             desc = "Goto Definition" },
			{ "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
			{ "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
			{ "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                     desc = "References" },
			{ "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
			{ "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
			-- Others
			{ "<leader>z",  function() Snacks.zen() end,                          desc = "Toggle Zen Mode" },
			{ "<leader>Z",  function() Snacks.zen.zoom() end,                     desc = "Toggle Zoom" },
			{ "<leader>gg", function() Snacks.lazygit() end,                      desc = "Lazygit" },
			{ "<leader>rc", function() Snacks.rename.rename_file() end,           desc = "Rename File" },
			{ "]]",         function() Snacks.words.jump(vim.v.count1) end,       desc = "Next Reference",           mode = { "n", "t" } },
			{ "[[",         function() Snacks.words.jump(-vim.v.count1) end,      desc = "Prev Reference",           mode = { "n", "t" } },
		},
		opts = {
			dashboard = {
				preset = {
					header = table.concat({
						" ███    ██ ██    ██ ██ ███    ███",
						" ████   ██ ██    ██ ██ ████  ████",
						" ██ ██  ██ ██    ██ ██ ██ ████ ██",
						" ██  ██ ██  ██  ██  ██ ██  ██  ██",
						" ██   ████   ████   ██ ██      ██",
					}, "\n"),
				},
				sections = {
					{ section = "header" },
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},
			lazygit = {
				-- automatically configure lazygit to use the current colorscheme
				-- and integrate edit with the current neovim instance
				configure = true,
				-- extra configuration for lazygit that will be merged with the default
				-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
				-- you need to double quote it: `"\"test\""`
				config = {
					os = {
						edit =
						'if not set? NVIM; and nvim -- {{filename}}; else; nvim --server "$NVIM" --remote-send "q"; and nvim --server "$NVIM" --remote-tab {{filename}}; end',
						editAtLine =
						'if not set? NVIM; and nvim +{{line}} -- {{filename}}; else; nvim --server "$NVIM" --remote-send "q"; and nvim --server "$NVIM" --remote-tab {{filename}}; and nvim --server "$NVIM" --remote-send ":{{line}}<CR>"; end',
						editAtLineAndWait = "nvim +{{line}} {{filename}}",
						editInTerminal = true,
						openDirInEditor =
						'if not set? NVIM; and nvim -- {{di}}; else; nvim --server "$NVIM" --remote-send "q"; and nvim --server "$NVIM" --remote-tab {{dir}}; end '
					},
				},
			}
		},
	},

	-- You can disable default plugins as follows:
	{ "max397574/better-escape.nvim", enabled = false },

	-- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
	{
		"L3MON4D3/LuaSnip",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom luasnip configuration such as filetype extend or custom snippets
			local luasnip = require("luasnip")
			luasnip.filetype_extend("dart", { "flutter" })
			luasnip.filetype_extend("javascript", { "javascriptreact" })
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.nvim-autopairs")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom autopairs configuration such as custom rules
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			npairs.add_rules(
				{
					Rule("$", "$", { "tex", "latex" })
					-- don't add a pair if the next character is %
							:with_pair(cond.not_after_regex("%%"))
					-- don't add a pair if  the previous character is xxx
							:with_pair(cond.not_before_regex("xxx", 3))
					-- don't move right when repeat character
							:with_move(cond.none())
					-- don't delete if the next character is xx
							:with_del(cond.not_after_regex("xx"))
					-- disable adding a newline when you press <cr>
							:with_cr(cond.none()),
				},
				-- disable for .vim files, but it work for another filetypes
				Rule("a", "a", "-vim")
			)
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		config = function(_, opts)
			opts.source_selector = {
				winbar = false,
				statusline = false
			}
			require("neo-tree").setup(opts)
		end
	},
}
