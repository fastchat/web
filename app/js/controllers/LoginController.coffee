fastchat.controller 'LoginController', ($scope, $location, api)->

  $scope.error = false

  $scope.login = ->
    console.log($scope.username, $scope.password)
    api.login($scope.username, $scope.password).then (data)->n
      console.log(data)
      if data === true
        $location.path('chat')
      else
        $('#login_errors').text(data.data.error)
        $('#login_errors').show()
