'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'AboutCtrl', ($scope) ->
  $scope.awesomeThings = [
    'HTML5 Boilerplate'
    'AngularJS'
    'Karma'
  ]
