fastchat.controller 'NavbarController', ($scope, $interval, $location, api)->

  $scope.logout = ->
    console.log('LOGGING OUT')
    api.logout().then (response)->
      if response.status == 200
        $location.path('/')
    false

  $scope.isLoggedIn = ->
    api.isLoggedIn()

  $scope.show = false
  $scope.title = 'Features in 0.5.0-Beta'
  $scope.content = 'Hello, World!'
  EIGHT_HOURS = 28800000

  newContent = ->
    api.whatIsNew().then (whatsNew)->
      if whatsNew
        $scope.show = true
        $scope.title = whatsNew.title
        $scope.content = whatsNew.content
      else
        $scope.show = false

  $interval(newContent, EIGHT_HOURS)

