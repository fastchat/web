fastchat.controller 'ChatController', ($scope, $routeParams, $location, $sce, $timeout, api, socket, notification, hotkeys)->

  ENTER_KEYCODE = 13

  currentGroup = $routeParams.group
  $scope.glued = true
  $scope.profile = null
  $scope.currentGroup = null
  $scope.groups = []
  $scope.avatars = {}
  $scope.media = {}
  
  #
  # Really wanted this to just be in the group, but it's not really
  # easy or good to modify it as a group property.
  #
  $scope.messages = []

  $scope.chat = ->
    text = $scope.messageText
    if text
      message = new Message({
        from: $scope.profile._id
        text: text
        sent: new Date()
        group: $scope.currentGroup._id
        hasMedia: false
      });
      
      #
      # has media?
      #

      socket.send(message)
      $scope.messages.unshift(message)
      $scope.messageText = ''
      $scope.currentGroup.lastMessage = message
      
    #send to socket io
    console.log('text?', text)

#  hotkeys.bindTo($scope)
#    .add({
#      combo: ['command+enter', 'ctrl+enter'],
#      description: 'Quickly send a message.',
#      allowIn: ['TEXTAREA'],
#      callback: $scope.chat
#    });


  $scope.mediaLoaded = (message)->
    typeof $scope.media[message._id] !== 'undefined'

  #
  # Scrolls to the bottom of the Chat.
  #
  # @param onBottom - Bool. If true, only scroll down
  # if the user was on the bottom already.
  #
  scroll = ->
    $("#chatbox").scrollTop($("#chatbox")[0].scrollHeight)

  onMessage = (data)->
    message = new Message(data)
    console.log('GOT MESSAGE', message)
    if message.group === $scope.currentGroup._id
      console.log('Current Group:', $scope.currentGroup)
      $scope.messages.unshift(message)
      if message.hasMedia
        $scope.getMedia(message)

      # Angular is watching our current group,
      # but I guess not the properties in it, so
      # we kindly tell it we updated something.
      $scope.$apply()
    notification.display(message);


  $scope.getMedia = (message)->
    api.getMedia($scope.currentGroup._id, message._id)
    .then (url)->
      $scope.media[message._id] = url
      # Give the page time to refresh before
      # scrolling to the bottom
      $timeout ->
        console.log('async')
        scroll();
      , 50
    .catch (err)->
      console.log('Error Getting Media: ', err)

  #
  # Unfortunetely, we have a lot of setup to do
  #
  init = ->
    #
    # As this runs, init socket if it's not already
    #
    socket.connect(api.token)
    socket.addListener('message', onMessage)

    console.log('Init')
    api.profile()
    .then (response)->
      $scope.profile = response

    api.groups().then (groups)->
      console.log('Groups!', groups)
      $scope.groups = groups
      if groups.length - 1 >= $scope.currentGroup
        $scope.currentGroup = groups[$routeParams.group]
	
        # Get all users avatars
        async.each $scope.currentGroup.members, (member, callback)->
          api.profileImage(member._id)
    	    .then (url)->
    	      console.log('Got avatar: ', url)
    	      $scope.avatars[member._id] = url
    	      img = $(".avatar")
    	      img.src = url
    	      callback()
          .catch (err)->
    	      console.log('Failed to find Avatar!', err)
    	      $scope.avatars[member._id] = '/img/default_avatar.png'
    	      callback()
        , (err)->
          console.log('Finished getting Avatars. Error? ', err)
      
        #  Now get the messages
        api.messages($scope.currentGroup._id).then (messages)->
          console.log('Messages', messages);
          messages.forEach (mes)->
            if mes.hasMedia
              $scope.getMedia(mes);
          $scope.messages = messages

      else
        $location.path('/chat/0')

  init()


  $scope.handleEnter = (evt)->
    if evt.keyCode == ENTER_KEYCODE && !(evt.shiftKey || evt.altKey)
      $scope.chat()
      evt.preventDefault()

