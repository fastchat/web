fastchat.service 'socket', ($http, $rootScope, $q)->

  @socket = null

  @connect = (token)->
    console.log('Connecting to Socket.io!', io)
    @socket = io.connect('/', { query: 'token=' + token })

  @disconnect = ->
    this

  @isConnected = ->
    @socket != null

  @send = (message)->
    if @isConnected()
      console.log('Error! You are not connected to socket.io!')
      return
    @socket.emit('message', message)

  @addListener = (type, listener)->
    @socket.removeAllListeners(type)
    @socket.on(type, listener)


