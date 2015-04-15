fastchat.service 'notification', ($http, $rootScope, $q)->

  this.notifications = []
  this.timer = null
  this.isBlurred = null

  self = this

  $(window).on 'blur', ->
    console.log('Blurred')
    self.isBlurred = true
  .on "focus", ->
    clearInterval(this.timer)
    console.log('Focused')
    self.isBlurred = false
    document.title = 'Fast Chat'
    self.timer = null

    if self.notifications
      for note in self.notifications
        note.close()

      self.notifications.length = 0; # clears array
    else
      self.notifications = []

  this.display = (message)->
    console.log('IS BLURRED?', self.isBlurred)
    return unless self.isBlurred

    messageNotification = new Notify(Group.usernameFromId(message.from), {
      body: message.text,
      icon: 'img/FastChat-120.png'
    });

    self.notifications.push(messageNotification)
    messageNotification.show()

    setInterval ->
      messageNotification.close()
    , 3000
