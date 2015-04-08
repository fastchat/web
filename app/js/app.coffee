fastchat = angular.module('fastchat', ['ngRoute', 'ngSanitize'])

fastchat.filter 'reverse', ->
  (items)->
    items.slice().reverse()

#
# Directive
#
fastchat.directive 'fileread', [->
  return
    scope:
      fileread: "="
    link: (scope, element, attributes)->
      element.bind 'change', (changeEvent)->
        reader = new FileReader()
        reader.onload = (loadEvent)->
          scope.$apply ->
            scope.fileread = loadEvent.target.result
        reader.readAsDataURL(changeEvent.target.files[0])
  ]

#
# Routes
#
fastchat.config ($routeProvider, $locationProvider)->
  $routeProvider
    .when '/',
      templateUrl: 'views/index.html'
    .when '/login',
      templateUrl:'views/login.html'
    .when('/register', {
      templateUrl:'views/register.html'
    .when '/chat/:group',
      templateUrl:'views/chat.html'
    .when '/chat',
      redirectTo: '/chat/0'
    .when '/profile',
      templateUrl:'views/profile.html'
    .when '/privacy',
      templateUrl:'views/privacy.html'
    .otherwise
      redirectTo: '/'

fastchat.run (api, authService)->
  console.log('Root Running')
  authService.init(api, ['/chat', '/group'])
