if true then return {} end -- WARN: ARCHIVED PLUGINS, KEEP THIS LINE UNCOMMENTED

return {
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
  {
    "b0o/incline.nvim",
    enabled = false,
    lazy = true,
    event = "BufEnter",
    dependencies = { "sainnhe/gruvbox-material" },
    config = function()
      local get_icon = require("astroui").get_icon
      local config = vim.fn["gruvbox_material#get_configuration"]()
      local palette = vim.fn["gruvbox_material#get_palette"](
        config.background, config.foreground, config.colors_override
      )
      local function get_diagnostic_label(props)
        local icons = {
          warn = { icon = get_icon("DiagnosticWarn"), guifg = palette.yellow[1] },
          hint = { icon = get_icon("DiagnosticHint"), guifg = palette.green[1] },
          info = { icon = get_icon("DiagnosticInfo"), guifg = palette.blue[1] },
          error = { icon = get_icon("DiagnosticError"), guifg = palette.red[1] },
        }
        local label = {}
        for severity, icon_info in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon_info.icon .. " " .. n .. " ", guifg = icon_info.guifg })
          end
        end
        return label
      end

      require("incline").setup({
        hide = {
          only_win = false,
          cursorline = true,
          focused_win = false,
        },
        window = {
          padding = 0,
          margin = { horizontal = 0 },
          placement = {
            vertical = "top",
            horizontal = "right",
          },
        },
        render = function(props)
          local helpers = require("incline.helpers")
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)

          local buffer = {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
            or "",
            " ",
            { filename,                   gui = modified },
            " ",
            { get_diagnostic_label(props) },
            guibg = "#282828",
          }
          return buffer
        end,
      })
    end,
  }
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
