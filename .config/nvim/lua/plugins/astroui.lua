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
            local config = vim.fn['gruvbox_material#get_configuration']()
            local palette = vim.fn['gruvbox_material#get_palette'](
              config.background,
              config.foreground,
              config.colors_override
            )

            -- return a table of highlights for telescope based on
            -- colors gotten from highlight groups
            return {
              TelescopeNormal = { bg = nil },
              TelescopeResultsTitle = { bg = nil, fg = nil },
              TelescopeResultsNormal = { bg = palette.bg1[1] },
              TelescopeResultsBorder = { bg = palette.bg1[1], fg = palette.bg1[1] },
              TelescopeBorder = { bg = nil, fg = palette.bg_statusline1[1] },
              TelescopePreviewTitle = { bg = palette.green[1], fg = nil },
              TelescopePreviewNormal = { bg = palette.bg_statusline2[1] },
              TelescopePreviewBorder = { bg = palette.bg_statusline2[1], fg = palette.bg_statusline2[1] },
              TelescopePromptTitle = { bg = palette.red[1], fg = nil },
              TelescopePromptNormal = { bg = palette.bg1[1], fg = palette.fg0[1] },
              TelescopePromptBorder = { bg = palette.bg1[1], fg = palette.bg1[1] },
              TelescopePromptPrefix = { bg = palette.bg1[1], fg = palette.red[1] },

              Normal = { bg = nil, fg = palette.fg0[1] },
              NormalFloat = { bg = nil, fg = palette.fg0[1] },
              FoldColumn = { bg = nil, fg = palette.grey0[1] },
              SignColumn = { bg = nil },
              EndOfBuffer = { bg = nil, fg = palette.grey0[1] },
              FloatBorder = { bg = nil },
              FloatTitle = { bg = nil, fg = palette.orange[1] },

              Visual = { bg = palette.bg3[1] },
              ColorColumn = { bg = palette.bg_visual_blue[1] },

              GitSignsAdd = { bg = nil, fg = palette.green[1] },
              GitSignsChange = { bg = nil, fg = palette.yellow[1] },
              GitSignsDelete = { bg = nil, fg = palette.red[1] },

              DiffAdd = { bg = nil, fg = palette.green[1] },
              DiffChange = { bg = nil, fg = palette.yellow[1] },
              DiffDelete = { bg = nil, fg = palette.red[1] },
              DiffText = { bg = nil, fg = palette.blue[1] },

              LspInfoBorder = { bg = nil, fg = palette.fg0[1] },
              DiagnosticSignWarn = { bg = nil, fg = palette.yellow[1] },

              ErrorMsg = { fg = palette.red[1] },

              CursorLine = { bg = palette.bg_current_word[1] },
              CurrentWord = { bg = palette.bg_current_word[1], },

              -- MatchParen = { bg = palette.grey2[1], fg = palette.bg0[1] },
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

-- let palette1 = {
--       \ 'bg_dim':           ['#141617',   '232'],
--       \ 'bg0':              ['#1d2021',   '234'],
--       \ 'bg1':              ['#282828',   '235'],
--       \ 'bg2':              ['#282828',   '235'],
--       \ 'bg3':              ['#3c3836',   '237'],
--       \ 'bg4':              ['#3c3836',   '237'],
--       \ 'bg5':              ['#504945',   '239'],
--       \ 'bg_statusline1':   ['#282828',   '235'],
--       \ 'bg_statusline2':   ['#32302f',   '235'],
--       \ 'bg_statusline3':   ['#504945',   '239'],
--       \ 'bg_diff_green':    ['#32361a',   '22'],
--       \ 'bg_visual_green':  ['#333e34',   '22'],
--       \ 'bg_diff_red':      ['#3c1f1e',   '52'],
--       \ 'bg_visual_red':    ['#442e2d',   '52'],
--       \ 'bg_diff_blue':     ['#0d3138',   '17'],
--       \ 'bg_visual_blue':   ['#2e3b3b',   '17'],
--       \ 'bg_visual_yellow': ['#473c29',   '94'],
--       \ 'bg_current_word':  ['#32302f',   '236']
--       \ }
--
-- --           let palette3 = {
--           \ 'grey0':            ['#7c6f64',   '243'],
--           \ 'grey1':            ['#928374',   '245'],
--           \ 'grey2':            ['#a89984',   '246'],
--           \ 'none':             ['NONE',      'NONE']
--           \ } "}}}
