return {
  {
    "Exafunction/windsurf.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.g.codeium_no_map_tab = true
      vim.g.codeium_os = 'Darwin'
      vim.g.codeium_arch = 'arm64'
      vim.keymap.set("i", "<M-y>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set("i", "<M-u>", function() return vim.fn["codeium#AcceptNextLine"]() end,
        { expr = true, silent = true })
      vim.keymap.set("i", "<M-i>", function() return vim.fn["codeium#AcceptNextWord"]() end,
        { expr = true, silent = true })
      vim.keymap.set("i", "<M-n>", function() return vim.fn["codeium#CycleCompletions"](1) end,
        { expr = true, silent = true })
      vim.keymap.set("i", "<M-b>", function() return vim.fn["codeium#CycleCompletions"](-1) end,
        { expr = true, silent = true })
      vim.keymap.set("i", "<M-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    -- event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = false,
        hide_during_completion = vim.g.ai_cmp,
        -- keymap = {
        --   accept = "<M-y>",
        --   accept_line = "<M-u>",
        --   accept_word = "<M-i>",
        --   next = "<M-n>",
        --   prev = "<M-b>",
        -- },
        keymap = {
          accept = false,
          accept_line = false,
          accept_word = false,
          next = false,
          prev = false,
        }
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = " Vibe", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  }
}
