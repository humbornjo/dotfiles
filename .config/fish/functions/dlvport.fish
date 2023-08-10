function dlvport
  set port $argv[1]
  echo "lua require('dap-go').setup( delve = { port = $port } )" | pbcopy
end
