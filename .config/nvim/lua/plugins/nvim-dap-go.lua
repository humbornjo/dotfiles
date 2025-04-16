return {
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
        port = "38697",
        host = "localhost",
      },
    })
  end,
}
