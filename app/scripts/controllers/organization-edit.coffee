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
  user
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
  ,
    key: 'favourite'
    title: translate.FORM_ORGANIZATION_FAVOURITE
    type: 'checkbox'
  ]

  $scope.formSubmit = (form) ->

    $scope.$broadcast 'schemaFormValidate'

    if form.$valid

      # Convert to an Organization model
      organization = new OrganizationModel $scope.organization

      # Validate
      try
        organization.validate()
      catch err
        console.log err

      console.log JSON.stringify organization.toObject(), null, 4

      if $scope.createNew

        engine.newOrganization (organization.toObject())
        .then (organization) ->

          if form.addNew
            # Add a new organization
            console.log 'todo'
          else
            # Go to organization view page
            $state.go 'organization.view',
              organizationId: organization.id

#          .catch (err) ->
#            formError.open 'twat'
