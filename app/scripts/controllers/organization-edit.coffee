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
      organization = new OrganizationModel $scope.organization

      # Validate
      try

        organization.validate()

        if $scope.createNew

          # Create a new organization
          engine.newOrganization (organization.toObject())
          .then (organization) ->

            if form.addNew
              # Add a new organization
              $state.reload()
            else
              # Go to organization view page
              $state.go '^.view',
                organizationId: organization.id

          .catch (err) ->
            formError.open 'API_ERROR_' + err.status

        else

          # Edit an existing organization
          # @todo

      catch err

        # Validation error
        # @todo
        console.log err
