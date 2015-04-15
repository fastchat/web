memberLookup = {}

Group = (properties)->
  for key of properties
    if properties.hasOwnProperty(key)
      this[key] = properties[key]

  self = this
  this.members.forEach (member)->
    memberLookup[member._id] = member.username

Group.usernameFromId = (id)->
  memberLookup[id]

Group.prototype.usernameFromId = (id)->
  memberLookup[id]

Group.prototype.groupName = ->
  if this.name
    return this.name

  this.members.map (elem)->
    elem.username
  .join(', ')


Group.prototype.avatarForUser = (user, api)->
  api.profileImage()


MakeGroups = (array)->
  made = []
  array.forEach (obj)->
    made.push(new Group(obj))
  made
