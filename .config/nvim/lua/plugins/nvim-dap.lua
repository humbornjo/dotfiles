local function get_executable()
  return coroutine.create(function(dap_run_co)
    local program = vim.fn.getcwd() .. "/"
    vim.ui.input({ prompt = "Path to executable: ", default = program }, function(input)
      coroutine.resume(dap_run_co, input)
    end)
  end)
end

local function get_arguments()
  return coroutine.create(function(dap_run_co)
    local args = {}
    vim.ui.input({ prompt = "Arguments: " }, function(input)
      args = vim.split(input or "", " ", { trimempty = true })
      coroutine.resume(dap_run_co, args)
    end)
  end)
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
          winbar = { controls = { enabled = true } },
          windows = { terminal = { position = "right" } }
        },
        config = function(_, opts)
          require("dap-view").setup(opts)
          local dap, dv = require("dap"), require("dap-view")
          dap.listeners.before.attach["dap-view-config"] = function() dv.open() end
          dap.listeners.before.launch["dap-view-config"] = function() dv.open() end
          dap.listeners.before.event_terminated["dap-view-config"] = function() dv.close() end
          dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end
        end
      },
    },
    config = function()
      local dap = require("dap")

      -- setup debuggers
      dap.adapters["lldb"] = {
        type = "executable",
        command = "codelldb", -- adjust as needed, must be absolute path
        name = "lldb",
      }
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand("$MASON/packages/js-debug-adapter") .. '/js-debug/src/dapDebugServer.js', "${port}",
          },
        },
      }

      -- setup configurations
      dap.configurations.go = nil
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          cwd = "${workspaceFolder}",
          program = get_executable,
          args = get_arguments,
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
        },
      }
      dap.configurations.typescript = dap.configurations.javascript

      local function dap_launch_config(filetype)
        local configurations = {
          python = {
            name = "Debug current file",
            type = "python",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            args = {},
            console = "integratedTerminal",
            justMyCode = false,
          },
          c = {
            name = "Debug current program",
            type = "lldb",
            request = "launch",
            program = "${fileDirname}/${fileBasenameNoExtension}",
            cwd = "${workspaceFolder}",
            args = {},
            stopOnEntry = false,
          },
          go = {
            name = "Debug current package",
            type = "go",
            request = "launch",
            mode = "debug",
            program = "${fileDirname}",
            cwd = "${workspaceFolder}",
            args = {},
          },
        }
        configurations.cpp = configurations.c

        local configuration = configurations[filetype]
        if not configuration then return nil end

        return {
          ["$schema"] = "https://raw.githubusercontent.com/mfussenegger/dapconfig-schema/master/dapconfig-schema.json",
          version = "0.2.0",
          configurations = { configuration },
        }
      end

      vim.api.nvim_create_user_command("DapInit", function(opts)
        local root = vim.fs.root(0, { ".git", "pyproject.toml", "go.mod", "CMakeLists.txt", "Makefile" })
          or vim.fn.getcwd()
        local directory = root .. "/.vscode"
        local path = directory .. "/launch.json"

        if vim.uv.fs_stat(path) and not opts.bang then
          vim.cmd.tabedit(vim.fn.fnameescape(path))
          return
        end

        local filetype = vim.bo.filetype
        local config = dap_launch_config(filetype)
        if not config then
          vim.notify("DapInit does not support filetype: " .. (filetype ~= "" and filetype or "unknown"), vim.log.levels.ERROR)
          return
        end

        vim.fn.mkdir(directory, "p")
        local json = vim.json.encode(config, { indent = "  " })
        vim.fn.writefile(vim.split(json, "\n", { plain = true }), path)
        vim.cmd.tabedit(vim.fn.fnameescape(path))
        vim.notify("Generated " .. path .. " for " .. filetype)
      end, {
        bang = true,
        desc = "Generate a project DAP launch.json for the current filetype",
      })

      vim.keymap.set("n", "<Leader>dI", "<Cmd>DapInit<CR>", { desc = "Initialize DAP config" })
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
          args = { "--check-go-version=false" },
        },
      })
    end,
  },
}
