'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:CookieCtrl
 # @description
 # # CookieCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'CookieCtrl', ($scope, $rootScope, cookies, cookieNames) ->

  cookieName = cookieNames.acceptCookieMessage

  $rootScope.hideCookieMessage = cookies.get cookieName

  $scope.year = new Date().getFullYear()

  $scope.onSubmit = ->

    cookies.set cookieName, 1,
      expires: 365

    $rootScope.hideCookieMessage = true
