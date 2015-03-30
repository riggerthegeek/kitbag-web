'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:FooterCtrl
 # @description
 # # FooterCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'FooterCtrl', ($scope, $rootScope) ->
  $scope.awesomeThings = [
    'HTML5 Boilerplate'
    'AngularJS'
    'Karma'
  ]
