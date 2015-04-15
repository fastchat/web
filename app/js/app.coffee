fastchat = angular.module('fastchat', ['ngRoute', 'ngSanitize'])

fastchat.filter 'reverse', ->
  (items)->
    items.slice().reverse()

fastchat.factory 'menu', [
  '$location',
  '$rootScope',
  '$anchorScroll',
  '$routeParams',
  '$timeout',
  ($location, $rootScope, $anchorScroll, $routeParams, $timeout)->

    sections = [
      {
        hash: 'chat'
        url: 'views/chat.html'
        name: 'Chat'
        type: 'link'
      }
    ]

    onLocationChange = ->
      path = $location.path()
      url = $location.url()
      hash = $location.hash()
      encodedHashIndex = url.indexOf('%23')
      if(encodedHashIndex > 0)
        hash = url.substr(encodedHashIndex + 3)
        url = url.substr(0, encodedHashIndex)
      urlWithoutHash = if hash then url.replace("##{hash}", '') else url

      matchPage = (section, page)->
        if path is page.url or "#{path}/index" is page.url
          self.selectSection(section)

      sections.forEach (section)->
        if section?.url is urlWithoutHash
          console.log 'found it', section
          self.selectSection(section)
          $timeout ->
            $location.hash($routeParams.scrollTo)
            $anchorScroll()
          , 100

    $rootScope.$on('$locationChangeSuccess', onLocationChange)

    self = {
      sections: sections

      selectSection: (section)->
        self.openedSection = section

      toggleSelectSection: (section)->
        self.openedSection = if self.openedSection is section then null else section

      isSectionSelected: (section)->
        self.openedSection is section

      selectPage: (section, page)->
        page and page.url and $location.path(page.url)
        self.currentSection = section
        self.currentPage = page

      isPageSelected: (page)->
        self.currentPage is page
    }
]

#
# Routes
#
fastchat.config ($routeProvider, $locationProvider)->
  $routeProvider
    .when '/',
      templateUrl: 'views/index.html'
    .when '/login',
      templateUrl: 'views/login.html'
    .when '/register',
      templateUrl: 'views/register.html'
    .when '/chat/:group',
      templateUrl: 'views/chat.html'
    .when '/chat',
      redirectTo: '/chat/0'
    .when '/profile',
      templateUrl: 'views/profile.html'
    .when '/privacy',
      templateUrl: 'views/privacy.html'
    .otherwise {
      redirectTo: '/'
    }

fastchat.run ->
  console.log('Root Running')
#  authService.init(api, ['/chat', '/group'])
