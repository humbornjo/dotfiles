-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    icons = require("config.icons"),
    colorscheme = "gruvbox-material",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      -- set highlights for all themes
      -- use a function override to let us use lua to retrieve
      -- colors from highlight group there is no default table
      -- so we don't need to put a parameter for this function
      init = function()
        local config = vim.fn["gruvbox_material#get_configuration"]()
        local palette =
            vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)

        -- return a table of highlights for telescope based on
        -- colors gotten from highlight groups
        return {
          ColorColumn = { bg = palette.bg1[1] },
          CursorLine = { bg = palette.bg_current_word[1] },
          CurrentWord = { bg = palette.bg_current_word[1] },
          ErrorMsg = { fg = palette.red[1] },
          Visual = { bg = palette.bg3[1] },
        }
      end,
    },
    status = {
      colors = function(hl)
        local get_hlgroup = require("astroui").get_hlgroup
        -- use helper function to get highlight group properties
        local comment_fg = get_hlgroup("Comment").fg
        hl.git_branch_fg = comment_fg
        hl.git_added = comment_fg
        hl.git_changed = comment_fg
        hl.git_removed = comment_fg
        hl.blank_bg = get_hlgroup("Folded").fg
        hl.file_info_bg = get_hlgroup("Visual").bg
        hl.nav_icon_bg = get_hlgroup("String").fg
        hl.nav_fg = hl.nav_icon_bg
        hl.folder_icon_bg = get_hlgroup("Error").fg
        return hl
      end,
      separators = {
        left = { "", "" }, -- separator for the left side of the statusline
        right = { " ", "" }, -- separator for the right side of the statusline
        -- tab = { "", "" },
        path = "  ",
        breadcrumbs = "  ",
      },
      attributes = { mode = { bold = true }, },
      icon_highlights = { file_icon = { statusline = false, }, },
    }
  },
}

-- function! gruvbox_material#get_palette(background, foreground, colors_override) "{{{
--   if a:background ==# 'hard' "{{{
--     if &background ==# 'dark'
--       let palette1 = {
--             \ 'bg_dim':           ['#141617',   '232'],
--             \ 'bg0':              ['#1d2021',   '234'],
--             \ 'bg1':              ['#282828',   '235'],
--             \ 'bg2':              ['#282828',   '235'],
--             \ 'bg3':              ['#3c3836',   '237'],
--             \ 'bg4':              ['#3c3836',   '237'],
--             \ 'bg5':              ['#504945',   '239'],
--             \ 'bg_statusline1':   ['#282828',   '235'],
--             \ 'bg_statusline2':   ['#32302f',   '235'],
--             \ 'bg_statusline3':   ['#504945',   '239'],
--             \ 'bg_diff_green':    ['#32361a',   '22'],
--             \ 'bg_visual_green':  ['#333e34',   '22'],
--             \ 'bg_diff_red':      ['#3c1f1e',   '52'],
--             \ 'bg_visual_red':    ['#442e2d',   '52'],
--             \ 'bg_diff_blue':     ['#0d3138',   '17'],
--             \ 'bg_visual_blue':   ['#2e3b3b',   '17'],
--             \ 'bg_visual_yellow': ['#473c29',   '94'],
--             \ 'bg_current_word':  ['#32302f',   '236']
--             \ }
--     else
--       let palette1 = {
--             \ 'bg_dim':           ['#f3eac7',   '229'],
--             \ 'bg0':              ['#f9f5d7',   '230'],
--             \ 'bg1':              ['#f5edca',   '229'],
--             \ 'bg2':              ['#f3eac7',   '229'],
--             \ 'bg3':              ['#f2e5bc',   '228'],
--             \ 'bg4':              ['#eee0b7',   '223'],
--             \ 'bg5':              ['#ebdbb2',   '223'],
--             \ 'bg_statusline1':   ['#f5edca',   '223'],
--             \ 'bg_statusline2':   ['#f3eac7',   '223'],
--             \ 'bg_statusline3':   ['#eee0b7',   '250'],
--             \ 'bg_diff_green':    ['#e4edc8',   '194'],
--             \ 'bg_visual_green':  ['#dde5c2',   '194'],
--             \ 'bg_diff_red':      ['#f8e4c9',   '217'],
--             \ 'bg_visual_red':    ['#f0ddc3',   '217'],
--             \ 'bg_diff_blue':     ['#e0e9d3',   '117'],
--             \ 'bg_visual_blue':   ['#d9e1cc',   '117'],
--             \ 'bg_visual_yellow': ['#f9eabf',   '226'],
--             \ 'bg_current_word':  ['#f3eac7',   '229']
--             \ }
--     endif "}}}
--   elseif a:background ==# 'medium' "{{{
--     if &background ==# 'dark'
--       let palette1 = {
--             \ 'bg_dim':           ['#1b1b1b',   '233'],
--             \ 'bg0':              ['#282828',   '235'],
--             \ 'bg1':              ['#32302f',   '236'],
--             \ 'bg2':              ['#32302f',   '236'],
--             \ 'bg3':              ['#45403d',   '237'],
--             \ 'bg4':              ['#45403d',   '237'],
--             \ 'bg5':              ['#5a524c',   '239'],
--             \ 'bg_statusline1':   ['#32302f',   '236'],
--             \ 'bg_statusline2':   ['#3a3735',   '236'],
--             \ 'bg_statusline3':   ['#504945',   '240'],
--             \ 'bg_diff_green':    ['#34381b',   '22'],
--             \ 'bg_visual_green':  ['#3b4439',   '22'],
--             \ 'bg_diff_red':      ['#402120',   '52'],
--             \ 'bg_visual_red':    ['#4c3432',   '52'],
--             \ 'bg_diff_blue':     ['#0e363e',   '17'],
--             \ 'bg_visual_blue':   ['#374141',   '17'],
--             \ 'bg_visual_yellow': ['#4f422e',   '94'],
--             \ 'bg_current_word':  ['#3c3836',   '237']
--             \ }
--     else
--       let palette1 = {
--             \ 'bg_dim':           ['#f2e5bc',   '228'],
--             \ 'bg0':              ['#fbf1c7',   '229'],
--             \ 'bg1':              ['#f4e8be',   '228'],
--             \ 'bg2':              ['#f2e5bc',   '228'],
--             \ 'bg3':              ['#eee0b7',   '223'],
--             \ 'bg4':              ['#e5d5ad',   '223'],
--             \ 'bg5':              ['#ddccab',   '250'],
--             \ 'bg_statusline1':   ['#f2e5bc',   '223'],
--             \ 'bg_statusline2':   ['#f2e5bc',   '223'],
--             \ 'bg_statusline3':   ['#e5d5ad',   '250'],
--             \ 'bg_diff_green':    ['#e6eabc',   '194'],
--             \ 'bg_visual_green':  ['#dee2b6',   '194'],
--             \ 'bg_diff_red':      ['#f9e0bb',   '217'],
--             \ 'bg_visual_red':    ['#f1d9b5',   '217'],
--             \ 'bg_diff_blue':     ['#e2e6c7',   '117'],
--             \ 'bg_visual_blue':   ['#dadec0',   '117'],
--             \ 'bg_visual_yellow': ['#fae7b3',   '226'],
--             \ 'bg_current_word':  ['#f2e5bc',   '228']
--             \ }
--     endif "}}}
--   else "{{{
--     if &background ==# 'dark'
--       let palette1 = {
--             \ 'bg_dim':           ['#252423',   '233'],
--             \ 'bg0':              ['#32302f',   '236'],
--             \ 'bg1':              ['#3c3836',   '237'],
--             \ 'bg2':              ['#3c3836',   '237'],
--             \ 'bg3':              ['#504945',   '239'],
--             \ 'bg4':              ['#504945',   '239'],
--             \ 'bg5':              ['#665c54',   '241'],
--             \ 'bg_statusline1':   ['#3c3836',   '237'],
--             \ 'bg_statusline2':   ['#46413e',   '237'],
--             \ 'bg_statusline3':   ['#5b534d',   '241'],
--             \ 'bg_diff_green':    ['#3d4220',   '22'],
--             \ 'bg_visual_green':  ['#424a3e',   '22'],
--             \ 'bg_diff_red':      ['#472322',   '52'],
--             \ 'bg_visual_red':    ['#543937',   '52'],
--             \ 'bg_diff_blue':     ['#0f3a42',   '17'],
--             \ 'bg_visual_blue':   ['#404946',   '17'],
--             \ 'bg_visual_yellow': ['#574833',   '94'],
--             \ 'bg_current_word':  ['#45403d',   '238']
--             \ }
--     else
--       let palette1 = {
--             \ 'bg_dim':           ['#ebdbb2',   '223'],
--             \ 'bg0':              ['#f2e5bc',   '228'],
--             \ 'bg1':              ['#eddeb5',   '223'],
--             \ 'bg2':              ['#ebdbb2',   '228'],
--             \ 'bg3':              ['#e6d5ae',   '223'],
--             \ 'bg4':              ['#dac9a5',   '250'],
--             \ 'bg5':              ['#d5c4a1',   '250'],
--             \ 'bg_statusline1':   ['#ebdbb2',   '223'],
--             \ 'bg_statusline2':   ['#ebdbb2',   '223'],
--             \ 'bg_statusline3':   ['#dac9a5',   '250'],
--             \ 'bg_diff_green':    ['#dfe1b4',   '194'],
--             \ 'bg_visual_green':  ['#d7d9ae',   '194'],
--             \ 'bg_diff_red':      ['#f7d9b9',   '217'],
--             \ 'bg_visual_red':    ['#efd2b3',   '217'],
--             \ 'bg_diff_blue':     ['#dbddbf',   '117'],
--             \ 'bg_visual_blue':   ['#d3d5b8',   '117'],
--             \ 'bg_visual_yellow': ['#f3deaa',   '226'],
--             \ 'bg_current_word':  ['#ebdbb2',   '227']
--             \ }
--     endif
--   endif "}}}
--   if a:foreground ==# 'material' "{{{
--     if &background ==# 'dark'
--       let palette2 = {
--             \ 'fg0':              ['#d4be98',   '223'],
--             \ 'fg1':              ['#ddc7a1',   '223'],
--             \ 'red':              ['#ea6962',   '167'],
--             \ 'orange':           ['#e78a4e',   '208'],
--             \ 'yellow':           ['#d8a657',   '214'],
--             \ 'green':            ['#a9b665',   '142'],
--             \ 'aqua':             ['#89b482',   '108'],
--             \ 'blue':             ['#7daea3',   '109'],
--             \ 'purple':           ['#d3869b',   '175'],
--             \ 'bg_red':           ['#ea6962',   '167'],
--             \ 'bg_green':         ['#a9b665',   '142'],
--             \ 'bg_yellow':        ['#d8a657',   '214']
--             \ }
--     else
--       let palette2 = {
--             \ 'fg0':              ['#654735',   '237'],
--             \ 'fg1':              ['#4f3829',   '237'],
--             \ 'red':              ['#c14a4a',   '88'],
--             \ 'orange':           ['#c35e0a',   '130'],
--             \ 'yellow':           ['#b47109',   '136'],
--             \ 'green':            ['#6c782e',   '100'],
--             \ 'aqua':             ['#4c7a5d',   '165'],
--             \ 'blue':             ['#45707a',   '24'],
--             \ 'purple':           ['#945e80',   '96'],
--             \ 'bg_red':           ['#ae5858',   '88'],
--             \ 'bg_green':         ['#6f8352',   '100'],
--             \ 'bg_yellow':        ['#a96b2c',   '130']
--             \ }
--     endif "}}}
--   elseif a:foreground ==# 'mix' "{{{
--     if &background ==# 'dark'
--       let palette2 = {
--             \ 'fg0':              ['#e2cca9',   '223'],
--             \ 'fg1':              ['#e2cca9',   '223'],
--             \ 'red':              ['#f2594b',   '167'],
--             \ 'orange':           ['#f28534',   '208'],
--             \ 'yellow':           ['#e9b143',   '214'],
--             \ 'green':            ['#b0b846',   '142'],
--             \ 'aqua':             ['#8bba7f',   '108'],
--             \ 'blue':             ['#80aa9e',   '109'],
--             \ 'purple':           ['#d3869b',   '175'],
--             \ 'bg_red':           ['#db4740',   '167'],
--             \ 'bg_green':         ['#b0b846',   '142'],
--             \ 'bg_yellow':        ['#e9b143',   '214']
--             \ }
--     else
--       let palette2 = {
--             \ 'fg0':              ['#514036',   '237'],
--             \ 'fg1':              ['#514036',   '237'],
--             \ 'red':              ['#af2528',   '88'],
--             \ 'orange':           ['#b94c07',   '130'],
--             \ 'yellow':           ['#b4730e',   '136'],
--             \ 'green':            ['#72761e',   '100'],
--             \ 'aqua':             ['#477a5b',   '165'],
--             \ 'blue':             ['#266b79',   '24'],
--             \ 'purple':           ['#924f79',   '96'],
--             \ 'bg_red':           ['#ae5858',   '88'],
--             \ 'bg_green':         ['#6f8352',   '100'],
--             \ 'bg_yellow':        ['#a96b2c',   '130']
--             \ }
--     endif "}}}
--   else "{{{
--     if &background ==# 'dark'
--       let palette2 = {
--             \ 'fg0':              ['#ebdbb2',   '223'],
--             \ 'fg1':              ['#ebdbb2',   '223'],
--             \ 'red':              ['#fb4934',   '167'],
--             \ 'orange':           ['#fe8019',   '208'],
--             \ 'yellow':           ['#fabd2f',   '214'],
--             \ 'green':            ['#b8bb26',   '142'],
--             \ 'aqua':             ['#8ec07c',   '108'],
--             \ 'blue':             ['#83a598',   '109'],
--             \ 'purple':           ['#d3869b',   '175'],
--             \ 'bg_red':           ['#cc241d',   '124'],
--             \ 'bg_green':         ['#b8bb26',   '106'],
--             \ 'bg_yellow':        ['#fabd2f',   '172']
--             \ }
--     else
--       let palette2 = {
--             \ 'fg0':              ['#3c3836',   '237'],
--             \ 'fg1':              ['#3c3836',   '237'],
--             \ 'red':              ['#9d0006',   '88'],
--             \ 'orange':           ['#af3a03',   '130'],
--             \ 'yellow':           ['#b57614',   '136'],
--             \ 'green':            ['#79740e',   '100'],
--             \ 'aqua':             ['#427b58',   '165'],
--             \ 'blue':             ['#076678',   '24'],
--             \ 'purple':           ['#8f3f71',   '96'],
--             \ 'bg_red':           ['#ae5858',   '88'],
--             \ 'bg_green':         ['#6f8352',   '100'],
--             \ 'bg_yellow':        ['#a96b2c',   '130']
--             \ }
--     endif
--   endif "}}}
--   if &background ==# 'dark' "{{{
--     let palette3 = {
--           \ 'grey0':            ['#7c6f64',   '243'],
--           \ 'grey1':            ['#928374',   '245'],
--           \ 'grey2':            ['#a89984',   '246'],
--           \ 'none':             ['NONE',      'NONE']
--           \ } "}}}
--   else "{{{
--     let palette3 = {
--           \ 'grey0':            ['#a89984',   '246'],
--           \ 'grey1':            ['#928374',   '245'],
--           \ 'grey2':            ['#7c6f64',   '243'],
--           \ 'none':             ['NONE',      'NONE']
--           \ }
--   endif "}}}
--   return extend(extend(extend(palette1, palette2), palette3), a:colors_override)
-- endfunction "}}}
