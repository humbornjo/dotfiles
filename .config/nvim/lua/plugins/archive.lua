if true then
	return {}
end -- WARN: ARCHIVED PLUGINS, KEEP THIS LINE UNCOMMENTED

return {
	{
		"uhs-robert/sshfs.nvim",
		opts = {
			connections = {
				ssh_configs = { -- Table of ssh config file locations to use
					"~/.ssh/config",
					"~/.orbstack/ssh/config",
					"/etc/ssh/ssh_config",
				},
				-- SSHFS mount options (table of key-value pairs converted to sshfs -o arguments)
				-- Boolean flags: set to true to include, false/nil to omit
				-- String/number values: converted to key=value format
				sshfs_options = {
					reconnect = true, -- Auto-reconnect on connection loss
					ConnectTimeout = 5, -- Connection timeout in seconds
					compression = "yes", -- Enable compression
					ServerAliveInterval = 15, -- Keep-alive interval (15s × 3 = 45s timeout)
					ServerAliveCountMax = 3, -- Keep-alive message count
					dir_cache = "yes", -- Enable directory caching
					dcache_timeout = 300, -- Cache timeout in seconds
					dcache_max_size = 10000, -- Max cache size
					-- allow_other = true,        -- Allow other users to access mount
					-- uid = "1000,gid=1000",     -- Set file ownership (use string for complex values)
					-- follow_symlinks = true,    -- Follow symbolic links
				},
				control_persist = "10m", -- How long to keep ControlMaster connection alive after last use
				socket_dir = vim.fn.expand("$HOME/.ssh/sockets"), -- Directory for ControlMaster sockets
			},
			mounts = {
				base_dir = vim.fn.expand("$HOME") .. "/Repository/mnt", -- where remote mounts are created
			},
			global_paths = {
				-- Optionally define default mount paths for ALL hosts
				-- These appear as options when connecting to any host
				-- Examples:
				-- "~/.config",
				-- "/var/www",
				-- "/srv",
				-- "/opt",
				-- "/var/log",
				-- "/etc",
				-- "/tmp",
				-- "/usr/local",
				-- "/data",
				-- "/var/lib",
			},
			host_paths = {
				-- Optionally define default mount paths for specific hosts
				-- These are shown in addition to global_paths
				-- Single path (string):
				-- ["my-server"] = "/var/www/html"
				--
				-- Multiple paths (array):
				-- ["dev-server"] = { "/var/www", "~/projects", "/opt/app" }
			},
			hooks = {
				on_exit = {
					auto_unmount = true, -- auto-disconnect all mounts on :q or exit
					clean_mount_folders = false, -- optionally clean up mount folders after disconnect
				},
				on_mount = {
					auto_change_to_dir = false, -- auto-change current directory to mount point
					auto_run = "find", -- "find" (default), "grep", "live_find", "live_grep", "terminal", "none", or a custom function(ctx)
				},
			},
			ui = {
				local_picker = {
					preferred_picker = "neo-tree", -- one of: "auto", "snacks", "fzf-lua", "mini", "telescope", "oil", "neo-tree", "nvim-tree", "yazi", "lf", "nnn", "ranger", "netrw"
					fallback_to_netrw = true, -- fallback to netrw if no picker is available
					netrw_command = "Explore", -- netrw command: "Explore", "Lexplore", "Sexplore", "Vexplore", "Texplore"
				},
				remote_picker = {
					preferred_picker = "snacks", -- one of: "auto", "snacks", "fzf-lua", "telescope", "mini"
				},
			},
			lead_prefix = "<leader>m", -- change keymap prefix (default: <leader>m)
			keymaps = {
				mount = "<leader>mm", -- creates an ssh connection and mounts via sshfs
				unmount = "<leader>mu", -- disconnects an ssh connection and unmounts via sshfs
				unmount_all = "<leader>mU", -- disconnects all ssh connections and unmounts via sshfs
				explore = "<leader>me", -- explore an sshfs mount using your native editor
				change_dir = "<leader>md", -- change dir to mount
				command = "<leader>mo", -- run command on mount
				config = "<leader>mc", -- edit ssh config
				reload = "<leader>mr", -- manually reload ssh config
				files = "<leader>mf", -- browse files using chosen picker
				grep = "<leader>mg", -- grep files using chosen picker
				terminal = "<leader>mt", -- open ssh terminal session
			},
		},
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
		keys = {
			{ "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
		},
		init = function()
			local data_path = vim.fn.stdpath("data")

			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
			vim.g.db_ui_show_database_icon = true
			vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
			vim.g.db_ui_use_nerd_fonts = true
			vim.g.db_ui_use_nvim_notify = true

			-- NOTE: The default behavior of auto-execution of queries on save is disabled
			-- this is useful when you have a big query that you don't want to run every time
			-- you save the file running those queries can crash neovim to run use the
			-- default keymap: <leader>S
			vim.g.db_ui_execute_on_save = false
		end,
	},
	{
		"aaronik/treewalker.nvim",
		keys = {
			{ "\x02k", "<cmd>Treewalker Up<cr>", mode = { "n", "v" }, desc = "TreeWalker Up" },
			{ "\x02j", "<cmd>Treewalker Down<cr>", mode = { "n", "v" }, desc = "TreeWalker Down" },

			{ "\x02h", "<cmd>Treewalker SwapLeft<cr>", mode = { "n", "v" }, desc = "TreeWalker SwapLeft" },
			{ "\x02l", "<cmd>Treewalker SwapRight<cr>", mode = { "n", "v" }, desc = "TreeWalker SwapRight" },
		},

		-- The following options are the defaults.
		-- Treewalker aims for sane defaults, so these are each individually optional,
		-- and setup() does not need to be called, so the whole opts block is optional as well.
		opts = {
			-- Whether to briefly highlight the node after jumping to it
			highlight = true,

			-- How long should above highlight last (in ms)
			highlight_duration = 250,

			-- The color of the above highlight. Must be a valid vim highlight group.
			-- (see :h highlight-group for options)
			highlight_group = "CursorLine",

			-- Whether the plugin adds movements to the jumplist -- true | false | 'left'
			--  true: All movements more than 1 line are added to the jumplist. This is the default,
			--        and is meant to cover most use cases. It's modeled on how { and } natively add
			--        to the jumplist.
			--  false: Treewalker does not add to the jumplist at all
			--  "left": Treewalker only adds :Treewalker Left to the jumplist. This is usually the most
			--          likely one to be confusing, so it has its own mode.
			jumplist = true,
		},
	},
	{
		{
			"mrcjkb/rustaceanvim", -- add lsp plugin
			version = "^5",
			lazy = false, -- This plugin is already lazy
			opts = function(_, opts)
				local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
				local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts("rust_analyzer")) or {}
				local server = {
					---@type table | (fun(project_root:string|nil, default_settings: table|nil):table) -- The rust-analyzer settings or a function that creates them.
					settings = function(project_root, default_settings)
						local astrolsp_settings = astrolsp_opts.settings or {}

						local merge_table = require("astrocore").extend_tbl(default_settings or {}, astrolsp_settings)
						local ra = require("rustaceanvim.config.server")
						-- load_rust_analyzer_settings merges any found settings with the passed in default settings table and then returns that table
						return ra.load_rust_analyzer_settings(project_root, {
							settings_file_pattern = "rust-analyzer.json",
							default_settings = merge_table,
						})
					end,
				}
				return { server = require("astrocore").extend_tbl(astrolsp_opts, server) }
			end,
			-- configure `rustaceanvim` by setting the `vim.g.rustaceanvim` variable
			config = function(_, opts)
				vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim)
			end,
		},
		{
			"AstroNvim/astrolsp",
			---@type AstroLSPOpts
			opts = {
				handlers = { rust_analyzer = false }, -- Let rustaceanvim setup `rust_analyzer`
			},
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = { "rust-analyzer" }, -- automatically install lsp
			},
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		-- For blink.cmp's completion
		-- source
		dependencies = {
			"saghen/blink.cmp",
		},
		keys = {
			{ "<leader>m", "<cmd>Markview toggle<cr>", desc = "Toggle markview" },
		},
		opts = {
			experimental = { check_rtp_message = false },
		},
		config = function(_, opts)
			require("markview").setup(opts)
			vim.api.nvim_create_autocmd("User", {
				pattern = "MarkviewAttach",
				callback = function(_)
					vim.cmd("Markview enable")
				end,
			})
		end,
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			-- check the installation instructions at
			-- https://github.com/folke/snacks.nvim
			"folke/snacks.nvim",
		},
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>yy",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>yw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<leader>yl",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
	},
	{
		"stevearc/overseer.nvim",
		enabled = false,
		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerSaveBundle",
			"OverseerLoadBundle",
			"OverseerDeleteBundle",
			"OverseerRunCmd",
			"OverseerRun",
			"OverseerInfo",
			"OverseerBuild",
			"OverseerQuickAction",
			"OverseerTaskAction",
			"OverseerClearCache",
		},
		opts = {
			dap = false,
			task_list = {
				bindings = {
					["<C-h>"] = false,
					["<C-j>"] = false,
					["<C-k>"] = false,
					["<C-l>"] = false,
				},
			},
			form = {
				win_opts = {
					winblend = 0,
				},
			},
			confirm = {
				win_opts = {
					winblend = 0,
				},
			},
			task_win = {
				win_opts = {
					winblend = 0,
				},
			},
		},
    -- stylua: ignore
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
      { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
    },
	},
}

-- =============================================================
-- symbol-usage.nvim
--
-- local function fmt_unit(num, unit)
--   return ("%s"):format(num)
-- end
--
-- local function text_format(symbol)
--   local res = {}
--
--   local round_start = { "", "SymbolUsageRounding" }
--   local round_end = { "", "SymbolUsageRounding" }
--
--   -- Indicator that shows if there are any other symbols in the same line
--   local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""
--
--   table.insert(res, round_start)
--   if symbol.references then
--     local s = fmt_unit(symbol.references, "usage")
--     table.insert(res, { "󰌹 ", "SymbolUsageRef" })
--     table.insert(res, { s, "SymbolUsageContent" })
--     table.insert(res, { " ", "SymbolUsageContent" })
--   end
--
--   if symbol.definition then
--     local s = fmt_unit(symbol.definition, "def")
--     table.insert(res, { "󰳽 ", "SymbolUsageDef" })
--     table.insert(res, { s, "SymbolUsageContent" })
--     table.insert(res, { " ", "SymbolUsageContent" })
--   end
--
--   if symbol.implementation then
--     local s = fmt_unit(symbol.implementation, "impl")
--     -- table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
--     table.insert(res, { " ", "SymbolUsageImpl" })
--     table.insert(res, { s, "SymbolUsageContent" })
--     table.insert(res, { " ", "SymbolUsageContent" })
--   end
--
--   if stacked_functions_content ~= "" then
--     table.insert(res, { "", "SymbolUsageImpl" })
--     table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
--     table.insert(res, { " ", "SymbolUsageContent" })
--   end
--
--   table.remove(res, #res)
--   table.insert(res, round_end)
--   return res
-- end
--
-- local SymbolKind = vim.lsp.protocol.SymbolKind
-- -- SymbolKind = {
-- --   File = 1,
-- --   Module = 2,
-- --   Namespace = 3,
-- --   Package = 4,
-- --   Class = 5,
-- --   Method = 6,
-- --   Property = 7,
-- --   Field = 8,
-- --   Constructor = 9,
-- --   Enum = 10,
-- --   Interface = 11,
-- --   Function = 12,
-- --   Variable = 13,
-- --   Constant = 14,
-- --   String = 15,
-- --   Number = 16,
-- --   Boolean = 17,
-- --   Array = 18,
-- --   Object = 19,
-- --   Key = 20,
-- --   Null = 21,
-- --   EnumMember = 22,
-- --   Struct = 23,
-- --   Event = 24,
-- --   Operator = 25,
-- --   TypeParameter = 26,
-- -- }
-- local common_kinds = {
--   SymbolKind.Interface,
--   SymbolKind.Class,
--   SymbolKind.Function,
--   SymbolKind.Method,
--   SymbolKind.Struct,
-- }
--
-- return {
--   "Wansmer/symbol-usage.nvim",
--   event = "LspAttach", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
--   priority = 1000,
--   ---@type UserOpts
--   config = function()
--     local function h(name)
--       return vim.api.nvim_get_hl(0, { name = name })
--     end
--
--     -- hl-groups can have any name
--     vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
--     vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
--     vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
--     vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
--     vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })
--     require("symbol-usage").setup({
--       text_format = text_format,
--       vt_position = "end_of_line",
--       request_pending_text = " ...",
--       implementation = {
--         enabled = true,
--       },
--       definition = {
--         enabled = false,
--       },
--       kinds = common_kinds,
--       filetypes = {
--         go = {
--           kinds = vim.list_extend({ SymbolKind.Constant }, common_kinds),
--         },
--         rust = {
--           kinds = vim.list_extend(
--             { SymbolKind.Constant, SymbolKind.Enum, SymbolKind.EnumMember },
--             common_kinds
--           ),
--         },
--       },
--     })
--   end,
-- }
