'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:OrganizationCreateCtrl
 # @description
 # # OrganizationCreateCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'OrganizationEditCtrl', (
  $scope,
  schema,
  organization,
  engine,
  translate,
  OrganizationModel,
  $state,
  user,
  formError
) ->

  $scope.user = user

  $scope.createNew = organization == null

  $scope.organization = if $scope.createNew then {} else organization.toObject()

  $scope.schema = schema

  $scope.pageTitle = if $scope.createNew then 'NEW_ORGANIZATION_PAGETITLE' else 'ORGANIZATION_EDIT'

  $scope.buttons = {}

  $scope.form = [
    key: 'name'
    title: translate.FORM_ORGANIZATION_NAME
    description: translate.ORGANIZATION_NAME_EXPLANATION
    placeholder: translate.ORGANIZATION_NAME_PLACEHOLDER
  ,
    key: 'favourite'
    title: translate.FORM_ORGANIZATION_FAVOURITE
    description: translate.ORGANIZATION_FAVOURITE_EXPLANATION
    type: 'checkbox'
  ]

  $scope.formSubmit = (form) ->

    if form.$valid

      # Convert to an Organization model
      data = new OrganizationModel $scope.organization

      if $scope.createNew == false
        data.setId = organization.getId()

      engine.saveOrganization (data)
        .then (organization) ->

          if form.addNew
            # Add a new organization
            $state.go $state.current, {},
              reload: true
          else
            # Go to organization view page
            $state.go '^.view',
              organizationId: organization.id

        .catch (err) ->
          console.log err
          formError.open 'API_ERROR_' + err.status
