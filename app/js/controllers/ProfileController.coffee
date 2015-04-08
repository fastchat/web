fastchat.controller 'ProfileController', ($scope, api)->

  $scope.profile = null

  api.profile().then (profile)->
    $scope.profile = profile
    $scope.profileImage()

  $scope.profileImage = ->
    api.profileImage().then (url)->
      img = document.querySelector( "#profileImage" )
      img.src = url

  $scope.uploadAvatar = ->
    toUpload = document.getElementById('avatarField')
    console.log('Uploading:', toUpload);

    api.uploadAvatar(toUpload.files[0]);

