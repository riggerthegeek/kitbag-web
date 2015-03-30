'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:AssetCtrl
 # @description
 # # AssetCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
  .controller 'AssetCtrl', ($scope, $stateParams, engine, GroupedAssetTypeModel) ->

#    $scope.assetTypes = []
#
#
#    engine.allAssets $stateParams.organizationId, true
#      .then (assetTypes) ->
#
#        $scope.assetTypes = assetTypes.map (assetType) ->
#          GroupedAssetType.toModel assetType
