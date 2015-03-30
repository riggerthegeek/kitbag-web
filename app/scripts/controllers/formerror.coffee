'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:FormerrorCtrl
 # @description
 # # FormerrorCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
  .controller 'FormerrorCtrl', ($scope, $modalInstance, errorTitle) ->

    $scope.errorTitle = errorTitle

    $scope.close = () ->

      $modalInstance.dismiss 'cancel'
