'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:AssetTypeCtrl
 # @description
 # # AssetTypeCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'AssetTypeCtrl', ($scope, organization, user, assetType) ->

  $scope.user = user

  $scope.assetType = assetType

  $scope.organization = organization

  $scope.snapMenu =
    buttons: [
      name: 'NEW_ASSET_PAGETITLE'
      state: '.asset.create({ assetTypeId: "' + assetType.getId() + '" })'
      class: 'add'
    ]
