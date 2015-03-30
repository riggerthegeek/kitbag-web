'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:OrganizationsCtrl
 # @description
 # # OrganizationsCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'OrganizationsCtrl', ($scope, $state, engine, organizations, formError, user) ->

  $scope.pageTitle = $state.current.data.pageTitle

  $scope.organizations = organizations

  $scope.user = user

  $scope.snapMenu = [
    name: 'NEW_ORGANIZATION_PAGETITLE'
    state: '.organization.create'
    class: 'add'
  ]


  $scope.favourite = ($event, organization) ->

    $event.preventDefault()
    $event.stopPropagation()

    engine.toggleOrganizationFavourite organization.id
    .then (result) ->
      # Toggle the favourite to the opposite of current value
      favourite = result.favourite

      organization.setFavourite favourite

      # Resort the collection
      $scope.organizations.sort()
    .catch (err) ->
      formError.open 'API_ERROR_' + err.status
