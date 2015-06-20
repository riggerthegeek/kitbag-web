'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:AssetTypeCtrl
 # @description
 # # AssetTypeCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'AssetTypeCtrl', ($scope, $state, engine, organization, user, assetType, assets) ->

  $scope.user = user

  $scope.assetType = assetType

  $scope.assets = assets

  $scope.organization = organization

  $scope.snapMenu =
    buttons: [
      name: 'NEW_ASSET_PAGETITLE'
      state: '.asset.create({ assetTypeId: "' + assetType.getId() + '" })'
      class: 'add'
    ,
      null
    ,
      name: 'EDIT_ASSET_TYPE_PAGETITLE'
      state: '.edit'
      class: 'edit'
    ,
      name: 'DELETE_ASSET_TYPE_PAGETITLE'
      confirm: 'CONFIRM_DELETE'
      class: 'delete'
      fn: ->
        engine.deleteAssetType organization.getId(), assetType.getId()
        .then ->
          $state.go '^.^'
    ]
