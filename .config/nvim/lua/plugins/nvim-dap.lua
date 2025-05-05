return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "igorlfs/nvim-dap-view", opts = {},
        config = function (_, opts)
          require("dap-view").setup(opts)
          local dap, dv = require("dap"), require("dap-view")
          dap.listeners.before.attach["dap-view-config"] = function()
            dv.open()
          end
          dap.listeners.before.launch["dap-view-config"] = function()
            dv.open()
          end
          dap.listeners.before.event_terminated["dap-view-config"] = function()
            dv.close()
          end
          dap.listeners.before.event_exited["dap-view-config"] = function()
            dv.close()
          end
        end
      },
    },
    config = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
        name = "lldb",
      }
      dap.configurations.go = nil
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
  },
  {
    "miroshQa/debugmaster.nvim",
    enabled = false,
    config = function()
      local dm = require("debugmaster")
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
      vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        delve = {
          path = "dlv",
          port = "${port}",
          host = "localhost",
        },
      })
    end,
  },
}
