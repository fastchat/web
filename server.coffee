#
# FastChat
# 2015
#

Hapi = require 'hapi'

CreateServer = (config)->

  server = new Hapi.Server()
  server.connection(port: 3000)

  server.route
    method: 'GET'
    path: "/{path*}"
    handler:
      directory:
        path: '/app'
        listing: no
        index: yes

  server

server = CreateServer()
server.start ->
  console.info 'Server started at ' + server.info.uri
