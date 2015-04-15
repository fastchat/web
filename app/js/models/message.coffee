#
#
#

Message = (properties)->
  for key of properties
    if properties.hasOwnProperty(key)
      this[key] = properties[key]
  this

#
# Translates the message.text to HTML.
# This is useful because line breaks will not show up correctly
# as \n anymore.
#
Message.prototype.toHTML = ->
  Autolinker.link( this.text, {twitter: false} )


MakeMessages = (array)->
  made = []
  array.forEach (obj)->
    made.push(new Message(obj))
  made
