'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:DashboardCtrl
 # @description
 # # DashboardCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'DashboardCtrl', ($scope, $state, lodash) ->


  setMenuState = (menu) ->

    menu.map (item) ->

      stateName = if lodash.has item, 'parentState' then item.parentState else item.state

      item.active = $state.includes stateName

      item


  $scope.dashboardMenu = setMenuState [
    name: 'ORGANIZATIONS_PAGETITLE'
    state: 'kitbag.private.organizations'
    icon: 'organization'
  ,
#    name: 'SCANNER_PAGETITLE'
#    state: 'kitbag.private.barcode_scanner'
#    icon: 'scanner'
#  ,
    name: 'SETTINGS_PAGETITLE'
    state: 'kitbag.private.settings'
    icon: 'settings'
  ,
#    name: 'HELP_PAGETITLE'
#    state: 'kitbag.private.help'
#    icon: 'help'
#  ,
    name: 'LOGOUT_PAGETITLE'
    state: 'kitbag.private.logout'
    icon: 'logout'
    confirm: 'LOGOUT_CONFIRM'

  ]

  $scope.footerMenu = setMenuState [
  ]

  $scope.footerClass = 12 / $scope.footerMenu.length
