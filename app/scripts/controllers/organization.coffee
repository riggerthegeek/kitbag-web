'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:OrganizationCtrl
 # @description
 # # OrganizationCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
  .controller 'OrganizationCtrl', ($scope, $stateParams, engine, assetTypes, organization, user) ->

    $scope.user = user

    $scope.organization = organization

    $scope.assetTypes = assetTypes

    $scope.canEdit = organization.canEdit user.getId()

    $scope.snapMenu =
      buttons: [
        name: 'NEW_ASSET_TYPE_PAGETITLE'
        state: '.asset-type.create'
        class: 'add'
      ]
