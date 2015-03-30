'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:Err404Ctrl
 # @description
 # # Err404Ctrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'ErrorCtrl', ($scope, $state) ->

  $scope.err = $state.current.err

  console.error $scope.err
