'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:BarcodeScannerCtrl
 # @description
 # # BarcodeScannerCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'BarcodeScannerCtrl', ($scope, $state) ->

  $scope.pageTitle = $state.current.data.pageTitle

  $scope.onDecodeError = (err) ->
    console.log 'decodeError'
    console.log err

  $scope.onSuccess = (decoded) ->
    console.log 'success'
    alert decoded

  $scope.onVideoError = (err) ->
    console.log 'videoError'
    console.log err
