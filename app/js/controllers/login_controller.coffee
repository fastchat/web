fastchat.controller 'LoginController', ($scope, $location, User)->

  $scope.error = false

  $scope.login = ->
    user = new User($scope.username, $scope.password)
    console.log 'user', user
    console.log($scope.username, $scope.password)
    api.login($scope.username, $scope.password).then (data)->
      console.log(data)
      if data is true
        $location.path('chat')
      else
        $('#login_errors').text(data.data.error)
        $('#login_errors').show()
