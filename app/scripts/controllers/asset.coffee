'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:AssetCtrl
 # @description
 # # AssetCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'AssetCtrl', (
  $scope,
  $state,
  engine,
  organization,
  user,
  asset
) ->

  $scope.user = user

  $scope.organization = organization

  $scope.asset = asset
