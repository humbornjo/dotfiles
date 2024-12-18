-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        -- change colorscheme
        colorscheme = "gruvbox-material",
        -- Icons can be configured throughout the interface
        icons = require "config.icons",
        highlights = {
          -- set highlights for all themes
          -- use a function override to let us use lua to retrieve
          -- colors from highlight group there is no default table
          -- so we don't need to put a parameter for this function
          init = function()
            local get_hlgroup = require("astroui").get_hlgroup
            -- get highlights from highlight groups
            local normal = get_hlgroup("Normal")
            local fg, bg = normal.fg, normal.bg
            local bg_alt = get_hlgroup("Visual").bg
            local green = get_hlgroup("String").fg
            local red = get_hlgroup("Error").fg
            -- return a table of highlights for telescope based on
            -- colors gotten from highlight groups
            return {
              TelescopeBorder = { fg = bg_alt, bg = bg },
              TelescopeNormal = { bg = bg },
              TelescopePreviewBorder = { fg = bg_alt, bg = bg_alt },
              TelescopePreviewNormal = { bg = bg_alt },
              TelescopePreviewTitle = { fg = bg, bg = green },
              TelescopePromptBorder = { fg = "#282828", bg = "#282828" },
              TelescopePromptNormal = { fg = fg, bg = "#282828" },
              TelescopePromptPrefix = { fg = red, bg = "#282828" },
              TelescopePromptTitle = { fg = bg, bg = red },
              TelescopeResultsBorder = { fg = "#282828", bg = "#282828" },
              TelescopeResultsNormal = { bg = "#282828" },
              TelescopeResultsTitle = { fg = bg, bg = bg },
            }
          end,
        },
      })
    end,
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      -- use codicons preset
      opts.preset = "codicons"
      -- set some missing symbol types
      opts.symbol_map = {
        Array = "",
        Boolean = "",
        Key = "",
        Namespace = "",
        Null = "",
        Number = "",
        Object = "",
        Package = "",
        String = "",
      }
    end,
  },
}

-- dark = {
--   hard = {
--     bg0 = "#1d2021",
--     bg1 = "#282828",
--     bg2 = "#282828",
--     bg3 = "#3c3836",
--     bg4 = "#3c3836",
--     bg5 = "#504945",
--     bg_statusline1 = "#282828",
--     bg_statusline2 = "#32302f",
--     bg_statusline3 = "#504945",
--     bg_visual_green = "#333e34",
--     bg_visual_red = "#442e2d",
--     bg_visual_blue = "#2e3b3b",
--     bg_visual_yellow = "#473c29",
--     bg_current_word = "#32302f",
--     bg_diff_red = "#3c1f1e",
--     bg_diff_green = "#32361a",
--     bg_diff_blue = "#0d3138",
--
--     term = {
--       bg5 = 239,
--     },
--   },
--   medium = {
--     bg0 = "#282828",
--     bg1 = "#32302f",
--     bg2 = "#32302f",
--     bg3 = "#45403d",
--     bg4 = "#45403d",
--     bg5 = "#5a524c",
--     bg_statusline1 = "#32302f",
--     bg_statusline2 = "#3a3735",
--     bg_statusline3 = "#504945",
--     bg_visual_green = "#3b4439",
--     bg_visual_red = "#4c3432",
--     bg_visual_blue = "#374141",
--     bg_visual_yellow = "#4f422e",
--     bg_current_word = "#3c3836",
--     bg_diff_red = "#402120",
--     bg_diff_green = "#34381b",
--     bg_diff_blue = "#0e363e",
--
--     term = {
--       bg5 = 239,
--     },
--   },
--   soft = {
--     bg0 = "#32302f",
--     bg1 = "#3c3836",
--     bg2 = "#3c3836",
--     bg3 = "#504945",
--     bg4 = "#504945",
--     bg5 = "#665c54",
--     bg_statusline1 = "#3c3836",
--     bg_statusline2 = "#46413e",
--     bg_statusline3 = "#5b534d",
--     bg_visual_green = "#424a3e",
--     bg_visual_red = "#543937",
--     bg_visual_blue = "#404946",
--     bg_visual_yellow = "#574833",
--     bg_current_word = "#45403d",
--     bg_diff_red = "#472322",
--     bg_diff_green = "#3d4220",
--     bg_diff_blue = "#0f3a42",
--
--     term = {
--       bg5 = 239,
--     },
--   },
