return {
  "rcarriga/nvim-dap-ui",
  config = function(plugin, opts)
    -- run default AstroNvim nvim-dap-ui configuration function
    local dap, dapui = require "dap", require "dapui"
    dap.listeners.after.event_initialized["dapui_config"] = nil
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    opts.expand_lines = false
    opts.layouts = { {
      elements = { {
        id = "scopes",
        size = 0.25
      }, {
        id = "breakpoints",
        size = 0.25,
      }, {
        id = "stacks",
        size = 0.25,
      }, {
        id = "watches",
        size = 0.25,
      } },
      position = "right",
      size = 40
    }, {
      elements = { {
        id = "repl",
        size = 0.7,
      }, {
        id = "console",
        size = 0.3,
      } },
      position = "bottom",
      size = 10
    } }
    dapui.setup(opts)
  end,
}
