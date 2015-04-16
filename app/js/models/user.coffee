'use strict'
#
# FastChat
# 2015
#

fastchat.factory 'User', ($http)->
  currentUser = null

  class User
    constructor: (@email, @password)->

    login: ->
      $http.post('/v1/user/login', email: @email, password: @password)
      .success (body)=>
        @access_token = body.access_token
        currentUser = this
      .error (err)->
        console.log 'err', err

    @currentUser: ->
      currentUser


  User
