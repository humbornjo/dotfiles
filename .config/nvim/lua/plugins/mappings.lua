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
          ["<leader>b"] = { name = "buffers", desc = " Buffers" },
          ["ga"] = { "<Plug>(EasyAlign)", desc = "vim-easy-align" },
        },
        x = {
          ["ga"] = { "<Plug>(EasyAlign)", desc = "vim-easy-align" },
        },
        i = {
          -- move like a ninja
          ["<C-j>"] = { "<C-o>j" },
          ["<C-k>"] = { "<C-o>k" },
          ["<C-h>"] = { "<C-o>h" },
          ["<C-l>"] = { "<C-o>l" },
          ["<C-d>"] = { "<esc>cw" },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
      },
    },
  },
}
