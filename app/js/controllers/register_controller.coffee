fastchat.controller 'RegisterController', ($scope, api)->

  $scope.error = false

  $scope.register = ->
    console.log($scope.username, $scope.password, $scope.passwordConfirm)
    api.register($scope.username, $scope.password)
