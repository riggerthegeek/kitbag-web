'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:AssetCtrl
 # @description
 # # AssetCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
  .controller 'AssetCtrl', ($scope, $stateParams) ->

    console.log 'asset ctrl'
    console.log $stateParams
