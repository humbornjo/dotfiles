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

      local dap_schema = "https://raw.githubusercontent.com/mfussenegger/dapconfig-schema/master/dapconfig-schema.json"

      local function dap_configuration(filetype)
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
            outputMode = "remote",
            program = "${fileDirname}",
            cwd = "${workspaceFolder}",
            args = {},
          },
          javascript = {
            name = "Debug current JavaScript file",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            args = {},
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },
          typescript = {
            name = "Debug current TypeScript file",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            args = {},
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },
        }
        configurations.cpp = configurations.c
        configurations.javascriptreact = configurations.javascript
        configurations.typescriptreact = configurations.typescript

        return configurations[filetype]
      end

      local function dap_launch_config(configuration)
        return {
          ["$schema"] = dap_schema,
          version = "0.2.0",
          configurations = configuration and { configuration } or {},
        }
      end

      local function write_launch_config(path, config)
        local json = vim.json.encode(config, { indent = "  " })
        vim.fn.writefile(vim.split(json, "\n", { plain = true }), path)
      end

      vim.api.nvim_create_user_command("DapInit", function(opts)
        local filetype = vim.bo.filetype
        local configuration = dap_configuration(filetype)
        local root = vim.fs.root(0, { ".git", "pyproject.toml", "go.mod", "CMakeLists.txt", "Makefile" })
          or vim.fn.getcwd()
        local directory = root .. "/.vscode"
        local path = directory .. "/launch.json"

        if vim.uv.fs_stat(path) and not opts.bang then
          if configuration then
            local ok, config = pcall(function()
              return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
            end)
            if not ok or type(config) ~= "table" or not vim.islist(config.configurations) then
              vim.cmd.edit(vim.fn.fnameescape(path))
              vim.notify("Could not add DAP configuration: launch.json is invalid", vim.log.levels.ERROR)
              return
            end

            local has_adapter = vim.iter(config.configurations):any(function(item)
              return item.type == configuration.type
            end)
            if not has_adapter then
              table.insert(config.configurations, configuration)
              config["$schema"] = config["$schema"] or dap_schema
              config.version = config.version or "0.2.0"
              write_launch_config(path, config)
              vim.notify("Added " .. filetype .. " DAP configuration")
            end
          end

          vim.cmd.edit(vim.fn.fnameescape(path))
          return
        end

        vim.fn.mkdir(directory, "p")
        write_launch_config(path, dap_launch_config(configuration))
        vim.cmd.edit(vim.fn.fnameescape(path))
        if configuration then
          vim.notify("Generated " .. path .. " for " .. filetype)
        else
          vim.notify("Generated empty " .. path .. "; unsupported filetype: " .. (filetype ~= "" and filetype or "unknown"))
        end
      end, {
        bang = true,
        desc = "Open or extend the project DAP launch.json for the current filetype",
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
