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
          ["<cmd>s"] = { "<leader>w" }
        },
        i = {
          -- move like a ninja
          ["<M-j>"] = { "<C-o>j" },
          ["<M-k>"] = { "<C-o>k" },
          ["<M-h>"] = { "<C-o>h" },
          ["<M-l>"] = { "<C-o>l" },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
      },
    },
  },
}
