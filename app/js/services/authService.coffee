fastchat.factory 'authService', ($rootScope, $location)->
  self = this
  loginPath = 'login'

  init: (api, restrictedPaths)->
    self.api = api
    self.restrictedPaths = restrictedPaths

    # register listener to watch route changes
    $rootScope.$on '$routeChangeStart', (event, next, current)->
      console.log("current loc:", $location.path())
      console.log("current route:", current)
      console.log("next route:", next)
      console.log('found?', self.restrictedPaths.indexOf($location.path()) > -1);
      console.log('Is logged in?', self.api.isLoggedIn() );
      # alternatively: if ( next.$$route.login === true ) { // must be configured in the route
      if self.restrictedPaths.indexOf($location.path()) > -1 && !self.api.isLoggedIn()
        return $location.path( loginPath )

      console.log("route change finished")

