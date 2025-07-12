-- center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { silent = true, desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Half page up (centered)" })

-- vim-zoom
local function zoom_is_zoomed()
  return vim.t.zoomed or false
end

local function zoom_is_only_window()
  return #vim.fn.tabpagebuflist() == 1
end

local function zoom_set_zoomed(state)
  vim.t.zoomed = state or false
end

local function zoom_clean_session_file()
  if vim.t.zoom_session_file then
    vim.fn.delete(vim.t.zoom_session_file)
    vim.t.zoom_session_file = nil
  end
end

local function zoom_session_file()
  if not vim.t.zoom_session_file then
    vim.t.zoom_session_file = vim.fn.tempname() .. '_' .. vim.fn.tabpagenr()
    if vim.fn.exists('##TabClosed') == 1 then
      vim.api.nvim_create_autocmd('TabClosed', {
        once = true,
        callback = zoom_clean_session_file,
      })
    elseif vim.fn.exists('##TabLeave') == 1 then
      vim.api.nvim_create_autocmd('TabLeave', {
        once = true,
        callback = zoom_clean_session_file,
      })
    end
  end
  return vim.t.zoom_session_file
end


local function zoom_toggle()
  if zoom_is_zoomed() then
    -- Zoom is active → restore
    vim.api.nvim_exec_autocmds('User', { pattern = 'ZoomPre', modeline = false })

    local cursor_pos = vim.fn.getpos('.')
    local current_buf = vim.fn.bufnr()

    vim.cmd('silent! source ' .. vim.fn.fnameescape(zoom_session_file()))
    vim.fn.setqflist(vim.t.qflist or {})
    vim.cmd('silent! b' .. current_buf)
    zoom_set_zoomed(false)
    vim.fn.setpos('.', cursor_pos)

    vim.api.nvim_exec_autocmds('User', { pattern = 'ZoomPost', modeline = false })
  else
    -- Not zoomed yet → create zoom
    if zoom_is_only_window() then return end

    local old_sessionopts = vim.o.sessionoptions
    local old_session = vim.v.this_session

    -- drop 'tabpages'
    local parts = vim.split(vim.o.sessionoptions, ',', { plain = true })
    parts = vim.tbl_filter(function(p) return p ~= 'tabpages' end, parts)
    vim.o.sessionoptions = table.concat(parts, ',')

    vim.o.sessionoptions = vim.fn.substitute(
      vim.o.sessionoptions, 'tabpages', '', 'g'
    )
    if vim.fn.matchstr(vim.o.sessionoptions, 'sesdir') == '' then
      vim.o.sessionoptions = 'blank,buffers,curdir,terminal,help'
    else
      vim.o.sessionoptions = 'blank,buffers,terminal,help'
    end

    vim.t.qflist = vim.fn.getqflist()
    vim.cmd('mksession! ' .. vim.fn.fnameescape(zoom_session_file()))
    vim.cmd('wincmd o')
    zoom_set_zoomed(true)

    vim.v.this_session = old_session
    vim.o.sessionoptions = old_sessionopts
  end
end

vim.keymap.set("n", "\x02z", function() zoom_toggle() end, { silent = true, desc = "Toggle zoom" })
