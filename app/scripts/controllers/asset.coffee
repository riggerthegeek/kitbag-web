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
  asset,
  schema
) ->

  $scope.user = user

  $scope.organization = organization

  $scope.data = asset

  $scope.schema = schema

  $scope.translate =
    serialNumber: 'FORM_SERIAL_NUMBER'
    lastMaintenanceDate: 'FORM_LAST_MAINTENANCE_DATE'
    purchaseDate: 'FORM_PURCHASE_DATE'
    returnRequested: 'FORM_RETURN_REQUESTED'
#    currentLocation: 'FORM_CURRENT_LOCATION'
