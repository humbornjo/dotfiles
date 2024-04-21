return {
  {
    "astronvim/astrocore",
    ---@type astrocoreopts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "buffer"
          ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "new tab" },
          ["<leader>bd"] = {
            function()
              require("astroui.status").heirline.buffer_picker(function(bufnr)
                require("astrocore.buffer").close(bufnr)
              end)
            end,
            desc = "pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<leader>b"]  = { name = "buffers", desc = " Buffers" },
          ["ga"]         = { "<Plug>(EasyAlign)", desc = "vim-easy-align" },
          ["<A-Up>"]     = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
          ["<A-Down>"]   = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
          ["<A-Left>"]   = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
          ["<A-Right>"]  = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
        },
        x = {
          ["ga"] = { "<Plug>(EasyAlign)", desc = "vim-easy-align" },
        },
        i = {
          -- move like a ninja
          ["<C-j>"] = { "<Down>" },
          ["<C-k>"] = { "<Up>" },
          ["<C-h>"] = { "<Left>" },
          ["<C-l>"] = { "<Right>" },
          ["<C-e>"] = { "<esc>ea" },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
      },
    },
  },
}
