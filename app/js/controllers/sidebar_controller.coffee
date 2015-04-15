'use strict'

fastchat.controller 'SidebarController', ($scope, $location, menu)->
  $scope.menu = menu
  $scope.selectedContext = "apps"

  @isSelected = (page)->
    menu.isPageSelected(page)

  @isOpen = (section)->
    menu.isSectionSelected(section)

  @toggleOpen = (section)->
    menu.toggleSelectSection(section)

  $scope.closeMenu = ->
    $timeout( -> $mdSidenav('left').close() )

  $scope.openMenu = ->
    $timeout( -> $mdSidenav('left').open() )

  $scope.noIndexFilter = @noIndexFilter = (item)->
    item.name isnt 'index'
