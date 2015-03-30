'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.controller:AssetTypeEditCtrl
 # @description
 # # AssetTypeEditCtrl
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.controller 'AssetTypeEditCtrl', (
  $scope,
  $state,
  user,
  assetType,
  organization,
  schema,
  translate,
  engine,
  AssetTypeModel
) ->

  validationMessages = {}

  $scope.user = user

  $scope.createNew = assetType == null

  $scope.pageTitle = if $scope.createNew then 'ASSET_TYPE_CREATE_PAGETITLE' else 'ASSET_TYPE_EDIT_PAGETITLE'

  $scope.organization = organization

  $scope.data = if $scope.createNew then {} else assetType

  $scope.snapMenu = [
    name: 'NEW_ASSET_TYPE_PAGETITLE',
    state: '^.^.create'
    class: 'add'
  ]

  $scope.form = [
    key: 'manufacturer'
    title: translate.FORM_MANUFACTURER
    description: translate.MANUFACTURER_EXPLANATION
    placeholder: 'Apple, Google'
    validationMessage: validationMessages.emailAddress
  ,
    key: 'model'
    title: translate.FORM_MODEL
    description: translate.MODEL_EXPLANATION
    placeholder: 'iPhone 5c, Nexus 6'
    validationMessage: validationMessages.password
  ,
    key: 'maintenanceSchedule'
    title: translate.FORM_MAINTENANCE_SCHEDULE
    description: translate.MAINTENANCE_SCHEDULE_EXPLANATION
    feedback: false
    minimum: 0
  ,
    type: 'submit'
    title: if $scope.createNew then translate.SUBMIT_CREATE else translate.SUBMIT_SAVE
    style: 'btn-success btn-lg btn-block'
  ]

  # Get the schema
  $scope.schema = schema

  # Submit the form
  $scope.formSubmit = (form) ->

    $scope.$broadcast 'schemaFormValidate'

    if form.$valid

      # Push to model instance
      data = AssetTypeModel.toModel $scope.data

      if $scope.createNew == false
        data.setId assetType.getId()

      # Add in the organizationId
      data.setOrganizationId organization.getId()

      # Attempt to save the data
      engine.saveAssetType data
        .then (result) ->
          # Push into a model instance
          obj = AssetTypeModel.toModel result

          $state.go '^.detail.view',
            organizationId: obj.getOrganizationId()
            assetTypeId: obj.getId()

        .catch (err) ->
          console.log err

  return
