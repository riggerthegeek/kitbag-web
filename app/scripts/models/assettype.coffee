'use strict'

###*
 # @ngdoc function
 # @name kitbagApp.factory:AssetTypeModel
 # @description
 # # AssetTypeModel
 # Controller of the kitbagApp
###
angular.module 'kitbagApp'
.factory 'AssetTypeModel', (lodash, Model) ->


  class AssetTypeModel extends Model



    constructor: (data) ->

      super data

      @manufacturer = @_data.manufacturer || null
      @model = @_data.model || null
      @maintenanceSchedule = @_data.maintenanceSchedule || null
      @organizationId = null
      @assets = @_data.assets || []

      # Set data
      @setOrganizationId @_data.organizationId


    assetCount: ->

      if lodash.isArray @assets then @assets.length else 0


    getMaintenanceSchedule: ->
      @maintenanceSchedule


    getManufacturer: ->
      @manufacturer


    getModel: ->
      @model


    getName: ->
      @manufacturer + ' ' + @model


    getOrganizationId: ->
      @organizationId


    setOrganizationId: (organizationId) ->
      @organizationId = Model.setString organizationId, null
      @



  AssetTypeModel
